import 'package:flutter/material.dart';

class KCategory {
  KCategory({
    @required this.name,
    @required this.imagePath,
  });

  final String name;
  final String imagePath;
}

List<KCategory> categories = [
  KCategory(name: 'Phones', imagePath: 'assets/images/CatPhones.png'),
  KCategory(name: 'Clothes', imagePath: 'assets/images/CatClothes.jpg'),
  KCategory(name: 'Shoes', imagePath: 'assets/images/CatShoes.jpg'),
  KCategory(name: 'Beauty&Health', imagePath: 'assets/images/CatBeauty.jpg'),
  KCategory(name: 'Laptops', imagePath: 'assets/images/CatLaptops.png'),
  KCategory(name: 'Furniture', imagePath: 'assets/images/CatFurniture.jpg'),
  KCategory(name: 'Watches', imagePath: 'assets/images/CatWatches.jpg'),
];
