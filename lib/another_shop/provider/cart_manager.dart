import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoppy/Extension/firebaseRef.dart';
import 'package:shoppy/another_shop/model/item_size.dart';
import 'package:shoppy/model/FBUser.dart';
import 'package:shoppy/model/product.dart';
import 'package:shoppy/provider/userState.dart';

class CartManager with ChangeNotifier {
  List<CartProduct> items = [];

  FBUser user;
  num productsPrice = 0;

  bool get isCartValid {
    for (final cr in items) {
      if (!cr.hasStock) return false;
    }

    return true;
  }

  void updateUser(UserState userManager) {
    user = currentUser;
    items.clear();

    if (user != null) {
      _loadCartItems();
    }
  }

  Future<void> _loadCartItems() async {
    final QuerySnapshot cartSnap = await firebaseReference(FirebaseRef.user)
        .doc(user.uid)
        .collection(FirebaseRef.cart.path)
        .get();

    items = cartSnap.docs
        .map((d) => CartProduct.fromDocument(d)..addListener(_onItemUpdated))
        .toList();
  }

  void addToCart(Product product) {
    // items.add(CartProduct.fromProduct(product));

    try {
      final cr = items.firstWhere((p) => p.stackable(product));
      cr.increment();
    } catch (e) {
      final cr = CartProduct.fromProduct(product);
      cr.addListener(_onItemUpdated);
      items.add(cr);

      /// add firestore
      cartReference(user).add(cr.toMap()).then((doc) => cr.id = doc.id);
      _onItemUpdated();
    }
    notifyListeners();
  }

  void removeOfCart(CartProduct cartProduct) {
    items.removeWhere((cr) => cr.id == cartProduct.id);
    cartReference(user).doc(cartProduct.id).delete();
    cartProduct.removeListener(_onItemUpdated);
    notifyListeners();
  }

  void _onItemUpdated() {
    print('UPDATE');

    productsPrice = 0.0;

    for (int i = 0; i < items.length; i++) {
      final cr = items[i];
      if (cr.quantity == 0) {
        removeOfCart(cr);
        i--;
        continue;
      }
      productsPrice += cr.totalPrice;
      _uodateCartProduct(cr);
    }

    print(productsPrice);
    notifyListeners();
  }

  void _uodateCartProduct(CartProduct cr) {
    if (cr.id != null) cartReference(user).doc(cr.id).update(cr.toMap());
  }
}

class CartProduct with ChangeNotifier {
  CartProduct.fromProduct(this.product) {
    productId = product.id;
    quantity = 1;
    size = product.selectedSize.title;
  }

  CartProduct.fromDocument(DocumentSnapshot document) {
    id = document.id;
    productId = document[CartKey.productionId] as String;
    quantity = document[CartKey.quantity] as int;
    size = document[CartKey.size] as String;

    /// Relation
    firebaseReference(FirebaseRef.product)
        .doc(productId)
        .get()
        .then((document) {
      product = Product.fromDocumant(document);
      notifyListeners();
    });
  }

  String id;
  String productId;
  int quantity;
  String size;

  Product product;

  ItemSize get itemSize {
    if (product == null) return null;
    return product.findSize(size);
  }

  num get unitPrice {
    if (product == null) return null;
    return itemSize.price ?? 0;
  }

  num get totalPrice => unitPrice * quantity;

  bool get hasStock {
    final size = itemSize;
    if (size == null) return false;
    return size.stock >= quantity;
  }

  Map<String, dynamic> toMap() {
    return {
      CartKey.productionId: productId,
      CartKey.quantity: quantity,
      CartKey.size: size,
    };
  }

  bool stackable(Product product) {
    return product.id == productId && product.selectedSize.title == size;
  }

  void increment() {
    quantity++;
    notifyListeners();
  }

  void decrement() {
    quantity--;
    notifyListeners();
  }
}

class CartKey {
  static final id = "id";
  static final productionId = "productionId";
  static final quantity = "quantity";
  static final size = "size";
}
