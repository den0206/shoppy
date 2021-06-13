import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoppy/Extension/firebaseRef.dart';
import 'package:shoppy/another_shop/model/order.dart';
import 'package:shoppy/another_shop/provider/cart_manager.dart';
import 'package:shoppy/model/product.dart';

class CheckoutManager with ChangeNotifier {
  CartManager cartManager;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void updateCart(CartManager cartManager) {
    this.cartManager = cartManager;
  }

  Future<void> checkout({Function onStockFail, Function onSuccess}) async {
    loading = true;

    try {
      await _decrementStock();
    } catch (e) {
      onStockFail(e);
      loading = false;
      debugPrint(e.toString());
      return;
    }

    /// get orderid
    final orderId = await _getOrderId();
    final order = Order.fromCartManager(cartManager);
    order.orderId = orderId.toString();

    /// upload to fireStore order
    await order.save();
    cartManager.clearOfCart();

    onSuccess(order);
    loading = false;
  }

  Future<int> _getOrderId() async {
    final ref = firebaseReference(FirebaseRef.aux).doc("ordercounter");

    try {
      final result = await firestore.runTransaction((tx) async {
        final doc = await tx.get(ref);
        final orderId = doc["current"] as int;
        tx.update(ref, {'current': orderId + 1});
        return {'orderId': orderId};
      });

      return result["orderId"];
    } catch (e) {
      debugPrint(e.toString());
      Future.error(e);
    }
  }

  Future<void> _decrementStock() async {
    return firestore.runTransaction((tx) async {
      final List<Product> productToUpdate = [];
      final List<Product> productsSoldout = [];

      for (final cartProduct in cartManager.items) {
        Product product;

        if (productToUpdate.any((p) => p.id == cartProduct.id)) {
          product = productToUpdate.firstWhere((p) => p.id == cartProduct.id);
        } else {
          final doc = await tx
              .get(firebaseReference(FirebaseRef.product).doc(cartProduct.id));

          product = Product.fromDocumant(doc);
        }

        cartProduct.product = product;

        final size = product.findSize(cartProduct.size);

        if (size.stock - cartProduct.quantity < 0) {
          productsSoldout.add(product);
        } else {
          size.stock -= cartProduct.quantity;
          productToUpdate.add(product);
        }

        /// display SoldOut Item
        ///
        if (productsSoldout.isNotEmpty) {
          return Future.error("${productsSoldout.length} Item Sold out!");
        }

        for (final product in productToUpdate) {
          tx.update(firebaseReference(FirebaseRef.product).doc(product.id),
              {ProductKey.sizes: product.exportSizeList()});
        }
      }

      return null;
    });
  }
}
