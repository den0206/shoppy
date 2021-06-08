import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoppy/Extension/firebaseRef.dart';
import 'package:shoppy/another_shop/model/section.dart';
import 'package:shoppy/consts/sample_products.dart';
import 'package:shoppy/model/product.dart';

class HomeManager with ChangeNotifier {
  List<Section> sections = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

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

  Future<void> updateSampe() async {
    _isLoading = true;
    notifyListeners();

    // await product.uploadToFireStore(editing: false);

    for (int i = 10; i < 20; i++) {
      print(i);
      final Product product = sampleProducts[i];
      await product.uploadToSample();
    }

    print("Finish");

    _isLoading = false;
    notifyListeners();
  }
}
