import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  const Category({
    Key key,
    @required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage(
                _categories[index]["categoryImagesPath"],
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 10,
          right: 10,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Theme.of(context).backgroundColor,
            child: Text(
              _categories[index]["categoryName"],
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Theme.of(context).textSelectionTheme.selectionColor,
              ),
            ),
          ),
        )
      ],
    );
  }
}

List<Map<String, Object>> _categories = [
  {
    'categoryName': 'Phones',
    'categoryImagesPath': 'assets/images/CatPhones.png',
  },
  {
    'categoryName': 'Clothes',
    'categoryImagesPath': 'assets/images/CatClothes.jpg',
  },
  {
    'categoryName': 'Shoes',
    'categoryImagesPath': 'assets/images/CatShoes.jpg',
  },
  {
    'categoryName': 'Beauty&Health',
    'categoryImagesPath': 'assets/images/CatBeauty.jpg',
  },
  {
    'categoryName': 'Laptops',
    'categoryImagesPath': 'assets/images/CatLaptops.png',
  },
  {
    'categoryName': 'Furniture',
    'categoryImagesPath': 'assets/images/CatFurniture.jpg',
  },
  {
    'categoryName': 'Watches',
    'categoryImagesPath': 'assets/images/CatWatches.jpg',
  },
];
