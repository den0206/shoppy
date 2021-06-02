import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseRef { user, product }

extension FirebaseRefExtension on FirebaseRef {
  String get path {
    switch (this) {
      case FirebaseRef.user:
        return "User";

      case FirebaseRef.product:
        return "Product";

      default:
        return "";
    }
  }
}

CollectionReference firebaseReference(FirebaseRef ref) {
  return FirebaseFirestore.instance.collection(ref.path);
}
