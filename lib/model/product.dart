import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shoppy/Extension/StoregeFunction.dart';
import 'package:shoppy/Extension/firebaseRef.dart';
import 'package:shoppy/another_shop/model/item_size.dart';

import 'package:shoppy/model/category.dart';
import 'package:shoppy/model/popular_brand.dart';

class Product with ChangeNotifier {
  Product({
    this.id,
    this.title,
    this.description,
    this.price,
    this.imageUrl,
    this.category,
    this.brand,
    this.quantity,
    this.isPopular,
    this.images,
    this.sizes,
  }) {
    images = images ?? [];
    sizes = sizes ?? [];
  }

  Product.fromDocumant(DocumentSnapshot document) {
    id = document.id;
    title = document[ProductKey.title];
    description = document[ProductKey.description];
    images = List<String>.from(document[ProductKey.images] as List<dynamic>);

    sizes = (document[ProductKey.sizes] as List<dynamic> ?? [])
        .map((s) => ItemSize.fromMap(s as Map<String, dynamic>))
        .toList();
  }

  String id;
  String title;
  String description;
  double price;
  String imageUrl;
  KCategory category;
  Brand brand;
  int quantity;
  bool isFavorite;
  bool isPopular;

  List<dynamic> newImages;
  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  List<String> images;
  List<ItemSize> sizes;
  ItemSize _selectedSize;
  ItemSize get selectedSize => _selectedSize;

  set selectedSize(ItemSize value) {
    _selectedSize = value;
    notifyListeners();
  }

  int get totalStock {
    int stock = 0;
    for (final size in sizes) {
      stock += size.stock;
    }

    return stock;
  }

  bool get hasStock {
    return totalStock > 0;
  }

  num get basePrice {
    num lowest = double.infinity;
    for (final size in sizes) {
      if (size.price < lowest && size.hasStock) lowest = size.price;
    }
    return lowest;
  }

  ItemSize findSize(String title) {
    try {
      return sizes.firstWhere((s) => s.title == title);
    } catch (e) {
      return null;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      ProductKey.title: title,
      ProductKey.description: description,
      ProductKey.images: [imageUrl],
      ProductKey.sizes: exportSizeList(),
    };
  }

  List<Map<String, dynamic>> exportSizeList() {
    return sizes.map((size) => size.toMap()).toList();
  }

  Future<void> uploadToFireStore({bool editing}) async {
    loading = true;
    notifyListeners();

    if (!editing) {
      final doc = firebaseReference(FirebaseRef.product).doc();
      id = doc.id;
    }

    final List<String> uploadImages = [];

    for (final newImage in newImages) {
      if (images.contains(newImage)) {
        uploadImages.add(newImage as String);
      } else {
        // final uuid = Uuid().v1();s
        final path = "$id/${newImages.indexOf(newImage)}";
        final downloadUrl =
            await uploadStorage(StorageRef.productImage, path, newImage);

        uploadImages.add(downloadUrl);
      }
    }

    for (final image in images) {
      if (!newImages.contains(image)) {
        try {
          final ref = FirebaseStorage.instance.refFromURL(image);
          await ref.delete();
        } catch (e) {
          debugPrint("Faill delete image");
        }
      }
    }
    images = uploadImages;

    if (!editing) {
      await firebaseReference(FirebaseRef.product).doc(id).set(toMap());
    } else {
      await firebaseReference(FirebaseRef.product).doc(id).update(toMap());
    }

    loading = false;
    notifyListeners();
  }

  Future<void> uploadToSample() async {
    loading = true;
    notifyListeners();

    final doc = firebaseReference(FirebaseRef.product).doc();
    id = doc.id;

    final List<String> uploadImages = [];

    for (final newImage in images) {
      if (images.contains(newImage)) {
        uploadImages.add(newImage);
      } else {
        // final uuid = Uuid().v1();s
        final path = "$id/${newImages.indexOf(newImage)}";
        final downloadUrl =
            await uploadStorage(StorageRef.productImage, path, newImage);

        uploadImages.add(downloadUrl);
      }
    }

    images = uploadImages;

    await firebaseReference(FirebaseRef.product).doc(id).set(toMap());

    loading = false;
    notifyListeners();
  }

  /// for edit
  Product clone() {
    return Product(
      id: id,
      title: title,
      description: description,
      price: price,
      imageUrl: imageUrl,
      category: category,
      brand: brand,
      quantity: quantity,
      isPopular: isPopular,
      images: List.from(images),
      sizes: sizes.map((size) => size.clone()).toList(),
    );
  }
}

class ProductKey {
  static final id = "id";
  static final title = "title";
  static final description = "description";
  static final imageUrl = "imageUrl";
  static final images = "images";
  static final price = "price";
  static final brand = "brand";
  static final quantity = "quantity";
  static final isPopular = "isPopular";

  static final sizes = "sizes";
}

// if (id == null) {
//   final doc = await firebaseReference(FirebaseRef.product).add(toMap());
//   id = doc.id;
// } else {
//   await firebaseReference(FirebaseRef.product).doc(id).update(toMap());
// }

// await firebaseReference(FirebaseRef.product)
//     .doc(id)
//     .update({ProductKey.images: uploadImages});
