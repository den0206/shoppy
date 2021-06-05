class ItemSize {
  ItemSize.fromMap(Map<String, dynamic> map) {
    title = map[ItemSizeKey.title] as String;
    price = map[ItemSizeKey.price] as num;
    stock = map[ItemSizeKey.stock] as int;
  }
  String title;
  num price;
  int stock;

  bool get hasStock => stock > 0;
}

class ItemSizeKey {
  static final title = "title";
  static final price = "price";
  static final stock = "stock";
}
