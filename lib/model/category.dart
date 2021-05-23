enum KCategory {
  phone,
  clothes,
  shoes,
  beauty_health,
  laptop,
  frniture,
  watches,
}

extension KCategoryExtension on KCategory {
  String get name {
    switch (this) {
      case KCategory.phone:
        return "Phones";
        break;
      case KCategory.clothes:
        return "Clothes";
        break;
      case KCategory.shoes:
        return "Shoes";
        break;
      case KCategory.beauty_health:
        return "Beauty&Health";
        break;
      case KCategory.laptop:
        return "Laptops";
        break;
      case KCategory.frniture:
        return "Furniture";
        break;
      case KCategory.watches:
        return "Watches";
      default:
        return "none";
    }
  }

  String get imagePath {
    switch (this) {
      case KCategory.phone:
        return "assets/images/CatPhones.png";
        break;
      case KCategory.clothes:
        return "assets/images/CatClothes.jpg";
        break;
      case KCategory.shoes:
        return "assets/images/CatShoes.jpg";
        break;
      case KCategory.beauty_health:
        return "assets/images/CatBeauty.jpg";
        break;
      case KCategory.laptop:
        return "assets/images/CatLaptops.png";
        break;
      case KCategory.frniture:
        return "assets/images/CatFurniture.jpg";
        break;
      case KCategory.watches:
        return "assets/images/CatWatches.jpg";
      default:
        return "none";
    }
  }
}

const List<KCategory> categories = KCategory.values;

// class KCategory {
//   KCategory({
//     @required this.name,
//     @required this.imagePath,
//   });

//   final String name;
//   final String imagePath;
// }

// List<KCategory> categories = [
//   KCategory(name: 'Phones', imagePath: 'assets/images/CatPhones.png'),
//   KCategory(name: 'Clothes', imagePath: 'assets/images/CatClothes.jpg'),
//   KCategory(name: 'Shoes', imagePath: 'assets/images/CatShoes.jpg'),
//   KCategory(name: 'Beauty&Health', imagePath: 'assets/images/CatBeauty.jpg'),
//   KCategory(name: 'Laptops', imagePath: 'assets/images/CatLaptops.png'),
//   KCategory(name: 'Furniture', imagePath: 'assets/images/CatFurniture.jpg'),
//   KCategory(name: 'Watches', imagePath: 'assets/images/CatWatches.jpg'),
// ];
