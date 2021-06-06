import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:shoppy/Extension/firebaseRef.dart';
import 'package:shoppy/model/product.dart';

class ProductManager with ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Product> allProduct = [];

  String _searchText = "";

  String get searchText => _searchText;
  set searchText(String value) {
    _searchText = value;
    notifyListeners();
  }

  List<Product> get filterdProducts {
    List<Product> filterdproducts = [];

    if (searchText.isEmpty) {
      filterdProducts.addAll(allProduct);
    } else {
      filterdProducts.addAll(allProduct.where(
          (p) => p.title.toLowerCase().contains(searchText.toLowerCase())));
    }

    return filterdproducts;
  }

  ProductManager() {
    _loadAllProduct();
  }

  Future<void> _loadAllProduct() async {
    final QuerySnapshot snapshots =
        await firebaseReference(FirebaseRef.product).get();

    allProduct = snapshots.docs
        .map((document) => Product.fromDocumant(document))
        .toList();

    notifyListeners();
  }

  Product findProductById(String id) {
    try {
      return allProduct.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }
}
