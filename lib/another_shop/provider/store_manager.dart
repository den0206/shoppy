import 'package:flutter/material.dart';
import 'package:shoppy/Extension/firebaseRef.dart';
import 'package:shoppy/another_shop/model/store.dart';

class StoreManager with ChangeNotifier {
  List<Store> stores = [];

  StoreManager() {
    _loadStoreList();
  }

  Future<void> _loadStoreList() async {
    final snapshot = await firebaseReference(FirebaseRef.store).get();
    stores = snapshot.docs.map((d) => Store.fromDocument(d)).toList();
    notifyListeners();
  }
}
