import 'package:flutter/material.dart';

class Brand {
  Brand({
    @required this.brandname,
    @required this.imagePath,
  });

  final String brandname;
  final String imagePath;
}

final List<Brand> brands = [
  Brand(brandname: "Addidas", imagePath: 'assets/images/addidas.jpg'),
  Brand(
    brandname: "apple",
    imagePath: 'assets/images/apple.jpg',
  ),
  Brand(brandname: "Dell", imagePath: 'assets/images/Dell.jpg'),
  Brand(brandname: "h&m", imagePath: 'assets/images/h&m.jpg'),
  Brand(brandname: "samsung", imagePath: 'assets/images/samsung.jpg'),
  Brand(brandname: "Huawei", imagePath: 'assets/images/Huawei.jpg'),
];
