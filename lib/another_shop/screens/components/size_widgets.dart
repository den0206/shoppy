import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/another_shop/model/item_size.dart';
import 'package:shoppy/model/product.dart';

class SizeWidget extends StatelessWidget {
  const SizeWidget({
    Key key,
    this.size,
  }) : super(key: key);

  final ItemSize size;

  @override
  Widget build(BuildContext context) {
    final product = context.watch<Product>();
    final selected = size == product.selectedSize;

    Color stockColor;

    if (!size.hasStock) {
      stockColor = Colors.red.withAlpha(50);
    } else if (selected) {
      stockColor = Theme.of(context).primaryColor;
    } else {
      stockColor = Colors.grey;
    }

    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: stockColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              color: stockColor,
              child: Text(
                size.title,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "R\$ ${size.price.toStringAsFixed(2)}",
                style: TextStyle(
                  color: stockColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
