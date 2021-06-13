import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shoppy/Extension/firebaseRef.dart';
import 'package:shoppy/another_shop/model/order.dart';
import 'package:shoppy/provider/userState.dart';

class AdminOrderManager with ChangeNotifier {
  List<Order> allOrders = [];
  StreamSubscription _subscription;

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }

  void updateAdmin(UserState userState) {
    final admin = adminEnable;
    allOrders.clear();
    _subscription.cancel();
    if (admin) {
      _listenToOrders();
    }
  }

  void _listenToOrders() {
    _subscription = firebaseReference(FirebaseRef.order).snapshots().listen(
      (event) {
        allOrders.clear();
        for (final doc in event.docs) {
          allOrders.add(Order.fromDocumant(doc));
        }
        notifyListeners();
      },
    );
  }
}
