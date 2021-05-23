import 'package:flutter/material.dart';
import 'package:shoppy/model/category.dart';
import 'package:shoppy/model/product.dart';

class ProductsProvider extends ChangeNotifier {
  List<Product> _products = sampleProducts;

  List<Product> get products => _products;

  List<Product> findByCategory(KCategory category) {
    List _categoryList =
        _products.where((element) => element.category == category).toList();

    return _categoryList;
  }
}
