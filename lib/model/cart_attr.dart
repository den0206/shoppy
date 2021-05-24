import 'package:flutter/material.dart';
import 'package:shoppy/model/product.dart';

class CartAttr {
  final Product product;
  final int quantity;
  CartAttr({
    @required this.product,
    @required this.quantity,
  });
}
