import 'package:flutter/material.dart';

class Category {
  Category({
    @required this.name,
    @required this.imagePath,
  });

  final String name;
  final String imagePath;
}

List<Category> categories = [
  Category(name: 'Phones', imagePath: 'assets/images/CatPhones.png'),
  Category(name: 'Clothes', imagePath: 'assets/images/CatClothes.jpg'),
  Category(name: 'Shoes', imagePath: 'assets/images/CatShoes.jpg'),
  Category(name: 'Beauty&Health', imagePath: 'assets/images/CatBeauty.jpg'),
  Category(name: 'Laptops', imagePath: 'assets/images/CatLaptops.png'),
  Category(name: 'Furniture', imagePath: 'assets/images/CatFurniture.jpg'),
  Category(name: 'Watches', imagePath: 'assets/images/CatWatches.jpg'),
];
