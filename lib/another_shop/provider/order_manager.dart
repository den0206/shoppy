import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoppy/Extension/firebaseRef.dart';
import 'package:shoppy/another_shop/model/order.dart';
import 'package:shoppy/model/FBUser.dart';
import 'package:shoppy/provider/userState.dart';

class OrderManager with ChangeNotifier {
  FBUser user;
  List<Order> orders = [];

  StreamSubscription _subscription;

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }

  void updateUser(UserState userState) {
    this.user = currentUser;
    orders.clear();
    _subscription?.cancel();

    if (user != null) {
      _listenToOrders();
    }
  }

  void _listenToOrders() {
    _subscription = firebaseReference(FirebaseRef.order)
        .where(OrderKey.userId, isEqualTo: user.uid)
        .snapshots()
        .listen(
      (event) {
        // orders.clear();
        for (final change in event.docChanges) {
          switch (change.type) {
            case DocumentChangeType.added:
              orders.add(Order.fromDocumant(change.doc));
              break;
            case DocumentChangeType.modified:
              final modifyOrder =
                  orders.firstWhere((o) => o.orderId == change.doc.id);
              modifyOrder.updateStatus(change.doc);
              break;
            case DocumentChangeType.removed:
              debugPrint("Delete Order");
              break;
          }
        }

        print(orders.length);

        notifyListeners();
      },
    );
  }
}
