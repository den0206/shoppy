import 'package:flutter/material.dart';
import 'package:shoppy/another_shop/model/section.dart';
import 'package:shoppy/another_shop/provider/product_manager.dart';
import 'package:shoppy/another_shop/screens/product_screen.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:provider/provider.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({
    Key key,
    @required this.item,
  }) : super(key: key);

  final SectionItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (item.productId != null) {
          final product =
              context.read<ProductManager>().findProductById(item.productId);

          if (product != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return ProductScreen(
                    product: product,
                  );
                },
              ),
            );
          }
        }
      },
      child: AspectRatio(
        aspectRatio: 1,
        child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: item.image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
