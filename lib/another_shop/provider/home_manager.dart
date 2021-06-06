import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoppy/Extension/firebaseRef.dart';
import 'package:shoppy/another_shop/model/section.dart';

class HomeManager with ChangeNotifier {
  List<Section> sections = [];

  HomeManager() {
    _loadSections();
  }

  Future<void> _loadSections() async {
    firebaseReference(FirebaseRef.home).snapshots().listen(
      (snapshot) {
        sections.clear();

        for (final DocumentSnapshot document in snapshot.docs) {
          sections.add(Section.fromDcument(document));
        }
        notifyListeners();
      },
    );
  }
}
