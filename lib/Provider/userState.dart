import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shoppy/Extension/firebaseRef.dart';
import 'package:shoppy/model/FBUser.dart';

class UserState with ChangeNotifier {
  final _auth = FirebaseAuth.instance;

  Future setUser({String uid}) async {
    final userId = uid ?? _auth.currentUser.uid;

    if (userId != null) {
      print("Set User State");
      final doc = await firebaseReference(FirebaseRef.user).doc(userId).get();

      currentUser = FBUser.fromDocument(doc);
      notifyListeners();
    } else {
      print("No User");
    }
  }

  Future logout() async {
    currentUser = null;
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }
}

FBUser currentUser;
