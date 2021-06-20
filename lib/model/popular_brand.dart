enum Brand { addidas, nike, apple, dell, h_m, samsung, huawei, all }

extension BrandExtension on Brand {
  String get name {
    switch (this) {
      case Brand.addidas:
        return "Addidas";
      case Brand.nike:
        return "Nike";
      case Brand.apple:
        return "Apple";
      case Brand.dell:
        return "Dell";
      case Brand.h_m:
        return "H&M";
      case Brand.samsung:
        return "Samsung";
      case Brand.huawei:
        return "Huawei";
      case Brand.all:
        return "All";
      default:
        return "None";
    }
  }

  String get imagePath {
    switch (this) {
      case Brand.addidas:
        return "assets/images/addidas.jpg";
      case Brand.nike:
        return "assets/images/nike.jpg";
      case Brand.apple:
        return "assets/images/apple.jpg";
      case Brand.dell:
        return "assets/images/Dell.jpg";
      case Brand.h_m:
        return "assets/images/h&m.jpg";
      case Brand.samsung:
        return "assets/images/samsung.jpg";
      case Brand.huawei:
        return "assets/images/Huawei.jpg";
      case Brand.all:
        return "All";
      default:
        return "None";
    }
  }
}

const List<Brand> brands = Brand.values;

Brand getBrand(String value) {
  for (final brand in brands) {
    if (brand.name == value) {
      return brand;
    }
  }
  return Brand.all;
}
