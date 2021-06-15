import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoppy/another_shop/model/adress.dart';

class FBUser {
  FBUser({
    this.uid,
    this.name,
    this.email,
    this.imageUrl,
  });

  String uid;
  String name;
  String email;
  String imageUrl;

  Address address;

  bool admin = false;

  FBUser.fromDocument(DocumentSnapshot document) {
    uid = document.id;
    name = document[UserKey.name];
    email = document[UserKey.email];

    imageUrl = document[UserKey.imageUrl] as String ?? null;

    final Map<String, dynamic> map = document.data() as Map<String, dynamic>;
    if (map.containsKey(UserKey.address))
      address =
          Address.fromMap(document[UserKey.address] as Map<String, dynamic>);
  }

  Map<String, dynamic> toMap() {
    return {
      UserKey.uid: uid,
      UserKey.name: name,
      UserKey.email: email,
      UserKey.imageUrl: imageUrl,
      if (address != null) UserKey.address: address.toMap()
    };
  }

  void setAddress(Address address) {
    this.address = address;

    /// save firestore;
  }
}

class UserKey {
  static final uid = "uid";
  static final name = "name";
  static final email = "email";
  static final imageUrl = "imageUrl";

  static final address = "address";
}
