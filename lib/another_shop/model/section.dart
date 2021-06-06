import 'package:cloud_firestore/cloud_firestore.dart';

class Section {
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
}

class SectionItem {
  SectionItem.fromMap(Map<String, dynamic> map) {
    image = map[SectionKey.image] as String;
    productId = map[SectionKey.productId] as String;
  }
  String image;
  String productId;
}

class SectionKey {
  static final name = "name";
  static final type = "type";

  /// section Item
  static final image = "image";
  static final productId = "productId";
}
