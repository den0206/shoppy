import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:shoppy/model/category.dart';

class Product {
  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    @required this.category,
    @required this.brand,
    @required this.quantity,
    @required this.isFavorite,
    @required this.isPopular,
  });

  String id;
  String title;
  String description;
  double price;
  String imageUrl;
  KCategory category;
  String brand;
  int quantity;
  bool isFavorite;
  bool isPopular;
}

List<Product> sampleProducts = [
  Product(
    id: 'Samsung1',
    title: 'Samsung Galaxy S9',
    description:
        'Samsung Galaxy S9 G960U 64GB Unlocked GSM 4G LTE Phone w/ 12MP Camera - Midnight Black',
    price: 50.99,
    imageUrl:
        'https://images-na.ssl-images-amazon.com/images/I/81%2Bh9mpyQmL._AC_SL1500_.jpg',
    brand: 'Samsung',
    category:
        KCategory(name: 'Phones', imagePath: 'assets/images/CatPhones.png'),
    quantity: 65,
    isPopular: false,
    isFavorite: false,
  ),
  Product(
    id: 'Samsung Galaxy A10s',
    title: 'Samsung Galaxy A10s',
    description:
        'Samsung Galaxy A10s A107M - 32GB, 6.2" HD+ Infinity-V Display, 13MP+2MP Dual Rear +8MP Front Cameras, GSM Unlocked Smartphone - Blue.',
    price: 50.99,
    imageUrl:
        'https://images-na.ssl-images-amazon.com/images/I/51ME-ADMjRL._AC_SL1000_.jpg',
    brand: 'Samsung ',
    category:
        KCategory(name: 'Phones', imagePath: 'assets/images/CatPhones.png'),
    quantity: 1002,
    isPopular: false,
    isFavorite: false,
  ),
  Product(
      id: 'Samsung Galaxy A51',
      title: 'Samsung Galaxy A51',
      description:
          'Samsung Galaxy A51 (128GB, 4GB) 6.5", 48MP Quad Camera, Dual SIM GSM Unlocked A515F/DS- Global 4G LTE International Model - Prism Crush Blue.',
      price: 50.99,
      imageUrl:
          'https://images-na.ssl-images-amazon.com/images/I/61HFJwSDQ4L._AC_SL1000_.jpg',
      brand: 'Samsung',
      category:
          KCategory(name: 'Phones', imagePath: 'assets/images/CatPhones.png'),
      quantity: 6423,
      isPopular: true,
      isFavorite: false),
  Product(
      id: 'Huawei P40 Pro',
      title: 'Huawei P40 Pro',
      description:
          'Huawei P40 Pro (5G) ELS-NX9 Dual/Hybrid-SIM 256GB (GSM Only | No CDMA) Factory Unlocked Smartphone (Silver Frost) - International Version',
      price: 900.99,
      imageUrl:
          'https://images-na.ssl-images-amazon.com/images/I/6186cnZIdoL._AC_SL1000_.jpg',
      brand: 'Huawei',
      category:
          KCategory(name: 'Phones', imagePath: 'assets/images/CatPhones.png'),
      quantity: 3,
      isPopular: true,
      isFavorite: false),
  Product(
      id: 'iPhone 12 Pro',
      title: 'iPhone 12 Pro',
      description:
          'New Apple iPhone 12 Pro (512GB, Gold) [Locked] + Carrier Subscription',
      price: 1100,
      imageUrl: 'https://m.media-amazon.com/images/I/71cSV-RTBSL.jpg',
      brand: 'Apple',
      category:
          KCategory(name: 'Phones', imagePath: 'assets/images/CatPhones.png'),
      quantity: 3,
      isPopular: true,
      isFavorite: false),
  Product(
      id: 'iPhone 12 Pro Max ',
      title: 'iPhone 12 Pro Max ',
      description:
          'New Apple iPhone 12 Pro Max (128GB, Graphite) [Locked] + Carrier Subscription',
      price: 50.99,
      imageUrl: 'https://m.media-amazon.com/images/I/71XXJC7V8tL._FMwebp__.jpg',
      brand: 'Apple',
      category:
          KCategory(name: 'Phones', imagePath: 'assets/images/CatPhones.png'),
      quantity: 2654,
      isPopular: false,
      isFavorite: false),
  Product(
      id: 'Hanes Mens ',
      title: 'Long Sleeve Beefy Henley Shirt',
      description: 'Hanes Men\'s Long Sleeve Beefy Henley Shirt ',
      price: 22.30,
      imageUrl:
          'https://images-na.ssl-images-amazon.com/images/I/91YHIgoKb4L._AC_UX425_.jpg',
      brand: 'No brand',
      category:
          KCategory(name: 'Phones', imagePath: 'assets/images/CatPhones.png'),
      quantity: 58466,
      isPopular: true,
      isFavorite: false),
  Product(
    id: 'Weave Jogger',
    title: 'Weave Jogger',
    description: 'Champion Mens Reverse Weave Jogger',
    price: 58.99,
    imageUrl: 'https://m.media-amazon.com/images/I/71g7tHQt-sL._AC_UL320_.jpg',
    brand: 'H&M',
    category:
        KCategory(name: 'Phones', imagePath: 'assets/images/CatPhones.png'),
    quantity: 84894,
    isPopular: false,
    isFavorite: false,
  ),
  Product(
    id: 'Adeliber Dresses for Womens',
    title: 'Adeliber Dresses for Womens',
    description:
        'Adeliber Dresses for Womens, Sexy Solid Sequined Stitching Shining Club Sheath Long Sleeved Mini Dress',
    price: 50.99,
    imageUrl:
        'https://images-na.ssl-images-amazon.com/images/I/7177o9jITiL._AC_UX466_.jpg',
    brand: 'H&M',
    category:
        KCategory(name: 'Phones', imagePath: 'assets/images/CatPhones.png'),
    quantity: 49847,
    isPopular: true,
    isFavorite: false,
  ),
  Product(
    id: 'Tanjun Sneakers',
    title: 'Tanjun Sneakers',
    description:
        'NIKE Men\'s Tanjun Sneakers, Breathable Textile Uppers and Comfortable Lightweight Cushioning ',
    price: 191.89,
    imageUrl:
        'https://images-na.ssl-images-amazon.com/images/I/71KVPm5KJdL._AC_UX500_.jpg',
    brand: 'Nike',
    category:
        KCategory(name: 'Phones', imagePath: 'assets/images/CatPhones.png'),
    quantity: 65489,
    isPopular: false,
    isFavorite: false,
  )
];
