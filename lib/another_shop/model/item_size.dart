class ItemSize {
  ItemSize({
    this.title,
    this.price,
    this.stock,
  });

  ItemSize.fromMap(Map<String, dynamic> map) {
    title = map[ItemSizeKey.title] as String;
    price = map[ItemSizeKey.price] as num;
    stock = map[ItemSizeKey.stock] as int;
  }

  String title;
  num price;
  int stock;

  Map<String, dynamic> toMap() {
    return {
      ItemSizeKey.title: title,
      ItemSizeKey.price: price,
      ItemSizeKey.stock: stock,
    };
  }

  bool get hasStock => stock > 0;

  ItemSize clone() {
    return ItemSize(
      title: title,
      price: price,
      stock: stock,
    );
  }
}

class ItemSizeKey {
  static final title = "title";
  static final price = "price";
  static final stock = "stock";
}
