import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoppy/Extension/firebaseRef.dart';
import 'package:shoppy/another_shop/model/adress.dart';
import 'package:shoppy/another_shop/provider/cart_manager.dart';

enum OrderStatus {
  cancel,
  preparing,
  transporting,
  deliverd,
}

extension OrderStatusExtension on OrderStatus {
  String get message {
    switch (this) {
      case OrderStatus.cancel:
        return "Cancel";
      case OrderStatus.preparing:
        return "Preparing";
      case OrderStatus.transporting:
        return "Transporting";
      case OrderStatus.deliverd:
        return "Deliverd";
      default:
        return "";
    }
  }
}

class Order {
  Order.fromCartManager(CartManager cartManager) {
    items = List.from(cartManager.items);
    price = cartManager.totalPrice;
    userId = cartManager.user.uid;
    address = cartManager.address;
    status = OrderStatus.preparing;
  }

  Order.fromDocumant(DocumentSnapshot doc) {
    orderId = doc.id;
    price = doc[OrderKey.price] as num;
    userId = doc[OrderKey.userId] as String;
    address = Address.fromMap(doc[OrderKey.address] as Map<String, dynamic>);
    date = doc[OrderKey.date] as Timestamp;

    status = OrderStatus.values[doc[OrderKey.status] as int];
  }

  String orderId;
  String get formatterId => "${orderId.padLeft(6, "0")}";
  String userId;
  num price;

  OrderStatus status;
  List<CartProduct> items;
  Address address;
  Timestamp date;

  Future<void> save() async {
    firebaseReference(FirebaseRef.cart).doc(orderId).set(toMap());
  }

  void updateStatus(DocumentSnapshot doc) {
    status = OrderStatus.values[doc[OrderKey.status] as int];
  }

  Map<String, dynamic> toMap() {
    return {
      OrderKey.orderId: orderId,
      OrderKey.userId: userId,
      OrderKey.price: price,
      OrderKey.items: items.map((e) => e.toMap()).toList(),
      OrderKey.address: address.toMap(),
      OrderKey.date: Timestamp.now(),
      OrderKey.status: status.index,
    };
  }

  /// control

  void cancel() {
    status = OrderStatus.cancel;
    firebaseReference(FirebaseRef.order)
        .doc(orderId)
        .update({OrderKey.status: status.index});
  }

  Function() get back {
    return status.index >= OrderStatus.transporting.index
        ? () {
            status = OrderStatus.values[status.index - 1];
            firebaseReference(FirebaseRef.order)
                .doc(orderId)
                .update({OrderKey.status: status.index});
          }
        : null;
  }

  Function() get advance {
    return status.index <= OrderStatus.transporting.index
        ? () {
            status = OrderStatus.values[status.index + 1];
            firebaseReference(FirebaseRef.order)
                .doc(orderId)
                .update({OrderKey.status: status.index});
          }
        : null;
  }
}

class OrderKey {
  static final orderId = "orderId";
  static final userId = "userId";
  static final price = "price";
  static final items = "items";
  static final address = "address";
  static final date = "date";
  static final status = "status";
}
