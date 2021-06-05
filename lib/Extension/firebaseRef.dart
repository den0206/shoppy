import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoppy/model/FBUser.dart';

enum FirebaseRef {
  user,
  product,
  cart,
  home,
}

extension FirebaseRefExtension on FirebaseRef {
  String get path {
    switch (this) {
      case FirebaseRef.user:
        return "User";
      case FirebaseRef.product:
        return "Product";
      case FirebaseRef.cart:
        return "Cart";
      case FirebaseRef.home:
        return "Home";

      default:
        return "";
    }
  }
}

CollectionReference firebaseReference(FirebaseRef ref) {
  return FirebaseFirestore.instance.collection(ref.path);
}

CollectionReference cartReference(FBUser user) {
  return firebaseReference(FirebaseRef.user)
      .doc(user.uid)
      .collection(FirebaseRef.cart.path);
}