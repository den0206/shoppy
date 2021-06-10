import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Section with ChangeNotifier {
  Section({
    this.name,
    this.type,
    this.items,
  }) {
    items = items ?? [];
  }

  Section.fromDcument(DocumentSnapshot document) {
    this.name = document[SectionKey.name] as String;
    this.type = document[SectionKey.type] as String;

    items = (document[SectionKey.image] as List)
        .map((i) => SectionItem.fromMap(i as Map<String, dynamic>))
        .toList();
  }
  String name;
  String type;
  List<SectionItem> items;

  void addItem(SectionItem item) {
    items.add(item);
    notifyListeners();
  }

  void removeitem(SectionItem item) {
    print(items);
    // items.remove(item);
    notifyListeners();
  }

  Section clone() {
    return Section(
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
}

class SectionKey {
  static final name = "name";
  static final type = "type";

  /// section Item
  static final image = "image";
  static final productId = "productId";
}
