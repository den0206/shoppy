import 'package:flutter/material.dart';
import 'package:shoppy/model/product.dart';

class WishlistProvider with ChangeNotifier {
  List<Product> _favItems = [];
  List<Product> get favItems => _favItems;

  void addAndRemoveFav(Product product) {
    if (_favItems.contains(product)) {
      removeItem(product);
    } else {
      _favItems.add(product);
      notifyListeners();
    }
  }

  void removeItem(Product product) {
    _favItems.remove(product);
    notifyListeners();
  }

  void clearItems() {
    _favItems.clear();
    notifyListeners();
  }
}
