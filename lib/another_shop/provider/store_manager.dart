import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shoppy/Extension/firebaseRef.dart';
import 'package:shoppy/another_shop/model/store.dart';

class StoreManager with ChangeNotifier {
  List<Store> stores = [];
  Timer _timer;

  StoreManager() {
    _loadStoreList();
    _startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  Future<void> _loadStoreList() async {
    final snapshot = await firebaseReference(FirebaseRef.store).get();
    stores = snapshot.docs.map((d) => Store.fromDocument(d)).toList();
    notifyListeners();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      _checkOpening();
    });
  }

  void _checkOpening() {
    for (final store in stores) {
      store.updateStatus();
    }
    notifyListeners();
  }
}
