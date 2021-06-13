import 'package:flutter/material.dart';
import 'package:shoppy/Extension/firebaseRef.dart';
import 'package:shoppy/another_shop/model/order.dart';
import 'package:shoppy/model/FBUser.dart';
import 'package:shoppy/provider/userState.dart';

class OrderManager with ChangeNotifier {
  FBUser user;
  List<Order> orders = [];

  void updateUser(UserState userState) {
    this.user = currentUser;

    if (user != null) {
      _listenToOrders();
    }
  }

  void _listenToOrders() {
    firebaseReference(FirebaseRef.order)
        .where(OrderKey.userId, isEqualTo: user.uid)
        .snapshots()
        .listen(
      (event) {
        orders.clear();
        for (final doc in event.docs) {
          orders.add(Order.fromDocumant(doc));
        }

        print(orders.length);
      },
    );
  }
}
