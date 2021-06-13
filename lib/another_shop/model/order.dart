import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoppy/Extension/firebaseRef.dart';
import 'package:shoppy/another_shop/model/adress.dart';
import 'package:shoppy/another_shop/provider/cart_manager.dart';

class Order {
  Order.fromCartManager(CartManager cartManager) {
    items = List.from(cartManager.items);
    price = cartManager.totalPrice;
    userId = cartManager.user.uid;
    address = cartManager.address;
  }

  Order.fromDocumant(DocumentSnapshot doc) {
    orderId = doc.id;
    price = doc[OrderKey.price] as num;
    userId = doc[OrderKey.userId] as String;
    address = Address.fromMap(doc[OrderKey.address] as Map<String, dynamic>);
  }

  String orderId;
  String userId;
  num price;
  List<CartProduct> items;
  Address address;
  Timestamp date;

  Future<void> save() async {
    firebaseReference(FirebaseRef.cart).doc(orderId).set(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      OrderKey.orderId: orderId,
      OrderKey.userId: userId,
      OrderKey.price: price,
      OrderKey.date: date,
      OrderKey.items: items.map((e) => e.toMap()).toList(),
      OrderKey.address: address.toMap(),
    };
  }
}

class OrderKey {
  static final orderId = "orderId";
  static final userId = "userId";
  static final price = "price";
  static final items = "items";
  static final address = "address";
  static final date = "date";
}
