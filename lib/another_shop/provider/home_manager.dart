import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoppy/Extension/firebaseRef.dart';

class HomeManager {
  List<Section> sections = [];

  HomeManager() {
    _loadSections();
  }

  Future<void> _loadSections() async {
    firebaseReference(FirebaseRef.home).snapshots().listen((snapshot) {
      sections.clear();

      for (final DocumentSnapshot document in snapshot.docs) {
        sections.add(Section.fromDcument(document));
      }
    });
  }
}

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

class SectionKey {
  static final name = "name";
  static final type = "type";

  /// section Item
  static final image = "image";
}

class SectionItem {
  SectionItem.fromMap(Map<String, dynamic> map) {
    image = map[SectionKey.image] as String;
  }
  String image;
}
