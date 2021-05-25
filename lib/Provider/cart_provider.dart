import 'package:flutter/material.dart';
import 'package:shoppy/model/cart_attr.dart';
import 'package:shoppy/model/product.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartAttr> _cartItems = {};
  Map<String, CartAttr> get cartItems => _cartItems;

  double get totalAmount {
    var total = 0.0;
    _cartItems.forEach(
      (key, value) {
        total += value.product.price * value.quantity;
      },
    );

    return total;
  }

  int get totalCount {
    var count = 0;
    _cartItems.forEach((key, value) {
      count += value.quantity;
    });

    return count;
  }

  void addTocart(Product product) {
    final productId = product.id;

    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
        productId,
        (existingItem) {
          return CartAttr(
              product: existingItem.product,
              quantity: existingItem.quantity + 1);
        },
      );
    } else {
      _cartItems.putIfAbsent(productId, () {
        return CartAttr(product: product, quantity: 1);
      });
    }
    // print(_cartItems);
    // print(_cartItems[productId].quantity);
    notifyListeners();
  }

  void reduceItemByOne(Product product) {
    final productId = product.id;

    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
        productId,
        (existingItem) {
          return CartAttr(
            product: existingItem.product,
            quantity: existingItem.quantity - 1,
          );
        },
      );
    }

    notifyListeners();
  }

  void removeItem(Product product) {
    final productId = product.id;

    if (_cartItems.containsKey(productId)) {
      _cartItems.removeWhere((key, value) => key == productId);
    }

    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
