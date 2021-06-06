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

      final docAdmin =
          await firebaseReference(FirebaseRef.admin).doc(currentUser.uid).get();

      if (docAdmin.exists) {
        currentUser.admin = true;
      }

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
bool get adminEnable => currentUser != null && currentUser.admin;
