import 'package:flutter/material.dart';
import 'package:shoppy/model/category.dart';
import 'package:shoppy/model/popular_brand.dart';
import 'package:shoppy/model/product.dart';

class ProductsProvider extends ChangeNotifier {
  List<Product> _products = sampleProducts;

  List<Product> get products => _products;
  List<Product> get popularProducts {
    return _products.where((element) => element.isPopular == true).toList();
  }

  Product findById(String productId) {
    return _products.firstWhere((element) => element.id == productId);
  }

  List<Product> findByCategory(KCategory category) {
    List _categoryList =
        _products.where((element) => element.category == category).toList();

    return _categoryList;
  }

  List<Product> fibdByBrand(Brand brand) {
    List _brandList =
        _products.where((element) => element.brand == brand).toList();

    return _brandList;
  }
}
