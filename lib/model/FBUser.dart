import 'package:cloud_firestore/cloud_firestore.dart';

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

  FBUser.fromDocument(DocumentSnapshot document) {
    uid = document.id;
    name = document[UserKey.name];
    email = document[UserKey.email];

    imageUrl = document[UserKey.imageUrl] as String ?? null;
  }

  Map<String, dynamic> toMap() {
    return {
      UserKey.uid: uid,
      UserKey.name: name,
      UserKey.email: email,
      UserKey.imageUrl: imageUrl,
    };
  }
}

class UserKey {
  static final uid = "uid";
  static final name = "name";
  static final email = "email";
  static final imageUrl = "imageUrl";
}
