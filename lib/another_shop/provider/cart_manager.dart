import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shoppy/Extension/firebaseRef.dart';
import 'package:shoppy/another_shop/model/adress.dart';
import 'package:shoppy/another_shop/model/item_size.dart';
import 'package:shoppy/consts/service/adress_number_searvice.dart';
import 'package:shoppy/model/FBUser.dart';
import 'package:shoppy/model/product.dart';
import 'package:shoppy/provider/userState.dart';

class CartManager with ChangeNotifier {
  List<CartProduct> items = [];

  FBUser user;
  Address address;
  bool get isAddressValid => address != null && deliverPrice != null;

  num productsPrice = 0;
  num deliverPrice;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set loading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  num get totalPrice => productsPrice + (deliverPrice ?? 0);

  bool get isCartValid {
    for (final cr in items) {
      if (!cr.hasStock) return false;
    }

    return true;
  }

  void updateUser(UserState userManager) {
    user = currentUser;
    productsPrice = 0.0;
    items.clear();
    removeAddress();

    if (user != null) {
      _loadCartItems();
      _loadUserAddress();
    }
  }

  Future<void> _loadCartItems() async {
    final QuerySnapshot cartSnap = await firebaseReference(FirebaseRef.user)
        .doc(user.uid)
        .collection(FirebaseRef.cart.path)
        .get();

    items = cartSnap.docs
        .map((d) => CartProduct.fromDocument(d)..addListener(_onItemUpdated))
        .toList();
  }

  void addToCart(Product product) {
    // items.add(CartProduct.fromProduct(product));

    try {
      final cr = items.firstWhere((p) => p.stackable(product));
      cr.increment();
    } catch (e) {
      final cr = CartProduct.fromProduct(product);
      cr.addListener(_onItemUpdated);
      items.add(cr);

      /// add firestore
      cartReference(user).add(cr.toMap()).then((doc) => cr.id = doc.id);
      _onItemUpdated();
    }
    notifyListeners();
  }

  void removeOfCart(CartProduct cartProduct) {
    items.removeWhere((cr) => cr.id == cartProduct.id);
    cartReference(user).doc(cartProduct.id).delete();
    cartProduct.removeListener(_onItemUpdated);
    notifyListeners();
  }

  void clearOfCart() {
    for (final cartProduct in items) {
      cartReference(user).doc(cartProduct.id).delete();
    }

    items.clear();
    notifyListeners();
  }

  void _onItemUpdated() {
    print('UPDATE');

    productsPrice = 0.0;

    for (int i = 0; i < items.length; i++) {
      final cr = items[i];
      if (cr.quantity == 0) {
        removeOfCart(cr);
        i--;
        continue;
      }
      productsPrice += cr.totalPrice;
      _updateCartProduct(cr);
    }

    print(productsPrice);
    notifyListeners();
  }

  void _updateCartProduct(CartProduct cr) {
    if (cr.id != null) cartReference(user).doc(cr.id).update(cr.toMap());
  }

  Future<void> _loadUserAddress() async {
    if (user.address != null && await caluculateDelivery(0, 0)) {
      address = user.address;
      notifyListeners();
    }
  }

  Future<void> getAddress(String cep) async {
    loading = true;
    final searvice = AdressNumberService();
    try {
      final cepAddress = await searvice.getAdDressFromCep(cep);

      if (cepAddress != null) {
        address = cepAddress;
        loading = false;
      }
    } catch (e) {
      debugPrint(e.toString());
      loading = false;
      return Future.error("Address Number InValid");
    }
  }

  void removeAddress() {
    address = null;
    deliverPrice = null;
    notifyListeners();
  }

  Future<void> setAddress(Address address) async {
    loading = true;
    this.address = address;
    print(address.city);

    if (await caluculateDelivery(0, 0)) {
      print("$deliverPrice");
      user.setAddress(address);
      loading = false;
    } else {
      loading = false;
      return Future.error("Deliverty price Error");
    }
  }

  Future<bool> caluculateDelivery(double lat, double long) async {
    final DocumentSnapshot doc =
        await firebaseReference(FirebaseRef.aux).doc("delivery").get();
    final latStore = doc["lat"] as double;
    final longStore = doc["long"] as double;

    final base = doc["base"] as num;
    final km = doc["km"] as num;
    final maxKm = doc["maxkm"] as num;

    double distance =
        Geolocator.distanceBetween(latStore, longStore, lat, long);

    distance /= 1000.0;
    print(distance);

    if (distance > maxKm) {
      return false;
    }

    deliverPrice = base + distance * km;
    return true;
  }
}

class CartProduct with ChangeNotifier {
  CartProduct.fromProduct(this._product) {
    productId = product.id;
    quantity = 1;
    size = product.selectedSize.title;
  }

  CartProduct.fromDocument(DocumentSnapshot document) {
    id = document.id;
    productId = document[CartKey.productionId] as String;
    quantity = document[CartKey.quantity] as int;
    size = document[CartKey.size] as String;
    fixedPrice = document[CartKey.fixedPrice] as num;

    /// Relation
    firebaseReference(FirebaseRef.product)
        .doc(productId)
        .get()
        .then((document) {
      product = Product.fromDocumant(document);
      // notifyListeners();
    });
  }

  String id;
  String productId;
  int quantity;
  String size;

  num fixedPrice;

  Product _product;
  Product get product => _product;
  set product(Product value) {
    _product = value;
    notifyListeners();
  }

  ItemSize get itemSize {
    if (product == null) return null;
    return product.findSize(size);
  }

  num get unitPrice {
    if (product == null) return null;
    return itemSize.price ?? 0;
  }

  num get totalPrice => unitPrice * quantity;

  bool get hasStock {
    if (product != null && product.deleted) return false;
    final size = itemSize;
    if (size == null) return false;
    return size.stock >= quantity;
  }

  Map<String, dynamic> toMap() {
    return {
      CartKey.productionId: productId,
      CartKey.quantity: quantity,
      CartKey.size: size,
      CartKey.fixedPrice: fixedPrice ?? unitPrice,
    };
  }

  bool stackable(Product product) {
    return product.id == productId && product.selectedSize.title == size;
  }

  void increment() {
    quantity++;
    notifyListeners();
  }

  void decrement() {
    quantity--;
    notifyListeners();
  }
}

class CartKey {
  static final id = "id";
  static final productionId = "productionId";
  static final quantity = "quantity";
  static final size = "size";
  static final fixedPrice = "fixedPrice";
}
