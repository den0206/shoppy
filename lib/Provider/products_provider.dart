import 'package:flutter/material.dart';
import 'package:shoppy/Extension/firebaseRef.dart';
import 'package:shoppy/consts/sample_products.dart';
import 'package:shoppy/model/category.dart';
import 'package:shoppy/model/popular_brand.dart';
import 'package:shoppy/model/product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _products = sampleProducts;
  List<Product> get products => _products;

  List<Product> get popularProducts {
    return _products.where((element) => element.isPopular == true).toList();
  }

  Future<void> fetchProducts() async {
    // try {
    //   final q = await firebaseReference(FirebaseRef.product).get();

    //   _products = q.docs.map((d) => Product.fromDocumant1(d));
    //   notifyListeners();
    // } catch (e) {
    //   print(e.toString());
    // }
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

  List<Product> findByQuery(String searchText) {
    List _queryList = _products
        .where((element) =>
            element.title.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    return _queryList;
  }
}
