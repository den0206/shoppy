enum KCategory {
  phone,
  clothes,
  shoes,
  beauty_health,
  laptop,
  frniture,
  watches,

  all
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
        return "All";
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

KCategory getKcategory(String value) {
  for (final category in categories) {
    if (category.name == value) {
      return category;
    }
  }
  return KCategory.all;
}
