import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoppy/Extension/firebaseRef.dart';
import 'package:shoppy/another_shop/model/section.dart';
import 'package:shoppy/consts/sample_products.dart';
import 'package:shoppy/model/product.dart';

class HomeManager with ChangeNotifier {
  List<Section> _sections = [];
  List<Section> _editingSections = [];

  bool editing = false;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  HomeManager() {
    _loadSections();
  }

  List<Section> get sections {
    if (editing) {
      return _editingSections;
    } else {
      return _sections;
    }
  }

  Future<void> _loadSections() async {
    firebaseReference(FirebaseRef.home).snapshots().listen(
      (snapshot) {
        _sections.clear();

        for (final DocumentSnapshot document in snapshot.docs) {
          _sections.add(Section.fromDcument(document));
        }
        notifyListeners();
      },
    );
  }

  void addSection(Section section) {
    _editingSections.add(section);
    notifyListeners();
  }

  void removeSection(Section section) {
    _editingSections.remove(section);
    notifyListeners();
  }

  void enterEditing() {
    editing = true;
    _editingSections = _sections.map((s) => s.clone()).toList();
    notifyListeners();
  }

  void saveEditing() {
    editing = false;
    notifyListeners();
  }

  void discardEditing() {
    editing = false;
    notifyListeners();
  }

  Future<void> updateSampe() async {
    _isLoading = true;
    notifyListeners();

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
