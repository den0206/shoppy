import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shoppy/Extension/StoregeFunction.dart';
import 'package:shoppy/Extension/firebaseRef.dart';

class Section with ChangeNotifier {
  Section({
    this.id,
    this.name,
    this.type,
    this.items,
  }) {
    items = items ?? [];
    originalItems = List.from(items);
  }

  Section.fromDcument(DocumentSnapshot document) {
    this.id = document[SectionKey.id] as String;
    this.name = document[SectionKey.name] as String;
    this.type = document[SectionKey.type] as String;

    items = (document[SectionKey.image] as List)
        .map((i) => SectionItem.fromMap(i as Map<String, dynamic>))
        .toList();
  }
  String id;
  String name;
  String type;
  List<SectionItem> items;
  List<SectionItem> originalItems;

  int pos;

  String _error;
  String get error => _error;
  set error(String value) {
    _error = value;
    notifyListeners();
  }

  bool valid() {
    if (name == null || name.isEmpty) {
      error = "No Name";
    } else if (items.isEmpty) {
      error = "No Item";
    } else {
      error = null;
    }
    return error == null;
  }

  void addItem(SectionItem item) {
    items.add(item);
    notifyListeners();
  }

  Future<void> save(int pos) async {
    if (id == null) {
      final doc = firebaseReference(FirebaseRef.home).doc();
      id = doc.id;
    }

    for (final item in items) {
      if (item.image is File) {
        item.image = await uploadStorage(StorageRef.home, "$id", item.image);
      }
    }

    for (final original in originalItems) {
      if (!items.contains(original)) {
        try {
          final ref = FirebaseStorage.instance.refFromURL(original.image);
          await ref.delete();
        } catch (e) {
          debugPrint("Faill delete image");
        }
      }
    }
    pos = pos;

    await firebaseReference(FirebaseRef.home).doc(id).set(toMap());

    /// upload
  }

  Future<void> delete() async {
    await firebaseReference(FirebaseRef.home).doc(id).delete();
    for (final item in items) {
      try {
        final ref = FirebaseStorage.instance.refFromURL(item.image as String);
        await ref.delete();
      } catch (e) {}
    }
  }

  void removeitem(SectionItem item) {
    print(items);
    // items.remove(item);
    notifyListeners();
  }

  Map<String, dynamic> toMap() {
    return {
      SectionKey.id: id,
      SectionKey.name: name,
      SectionKey.type: type,
      SectionKey.items: items.map((i) => i.toMap()).toList(),
      SectionKey.pos: pos
    };
  }

  Section clone() {
    return Section(
      id: id,
      name: name,
      type: type,
      items: items.map((e) => e.clone()).toList(),
    );
  }
}

class SectionItem {
  SectionItem({
    this.image,
    this.productId,
  });

  SectionItem.fromMap(Map<String, dynamic> map) {
    image = map[SectionKey.image] as String;
    productId = map[SectionKey.productId] as String;
  }
  dynamic image;
  String productId;

  SectionItem clone() {
    return SectionItem(
      image: image,
      productId: productId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      SectionKey.image: image,
      SectionKey.productId: productId,
    };
  }
}

class SectionKey {
  static final id = "id";
  static final name = "name";
  static final type = "type";
  static final items = "items";
  static final pos = "pos";

  /// section Item
  static final image = "image";
  static final productId = "productId";
}
