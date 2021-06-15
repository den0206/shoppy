import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoppy/Extension/firebaseRef.dart';
import 'package:shoppy/another_shop/model/order.dart';
import 'package:shoppy/model/FBUser.dart';
import 'package:shoppy/provider/userState.dart';

class AdminOrderManager with ChangeNotifier {
  final List<Order> _orders = [];
  StreamSubscription _subscription;

  FBUser userFilter;
  List<OrderStatus> statusFilter = [OrderStatus.preparing];

  List<Order> get filterdOrders {
    List<Order> outPut = _orders.reversed.toList();

    if (userFilter != null) {
      outPut = outPut.where((o) => o.userId == userFilter.uid).toList();
    }

    return outPut;
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }

  void setUserFilter(FBUser user) {
    userFilter = user;
    notifyListeners();
  }

  void updateAdmin(UserState userState) {
    final admin = adminEnable;
    _orders.clear();
    _subscription?.cancel();
    if (admin) {
      _listenToOrders();
    }
  }

  void setUserStatusFilter({OrderStatus status, bool enable}) {
    if (enable) {
      statusFilter.add(status);
    } else {
      statusFilter.remove(status);
    }
    notifyListeners();
  }

  void _listenToOrders() {
    _subscription = firebaseReference(FirebaseRef.order).snapshots().listen(
      (event) {
        for (final change in event.docChanges) {
          switch (change.type) {
            case DocumentChangeType.added:
              _orders.add(Order.fromDocumant(change.doc));
              break;
            case DocumentChangeType.modified:
              final modOrder =
                  _orders.firstWhere((o) => o.orderId == change.doc.id);
              modOrder.updateStatus(change.doc);
              break;
            case DocumentChangeType.removed:
              print("Delete Order");
              break;
          }
        }
        notifyListeners();
      },
    );
  }
}
