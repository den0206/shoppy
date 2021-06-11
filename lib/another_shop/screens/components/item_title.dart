import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppy/another_shop/model/section.dart';
import 'package:shoppy/another_shop/provider/home_manager.dart';
import 'package:shoppy/another_shop/provider/product_manager.dart';
import 'package:shoppy/another_shop/screens/components/images_form.dart';
import 'package:shoppy/another_shop/screens/product_screen.dart';
import 'package:shoppy/another_shop/screens/select_product.dart';
import 'package:shoppy/model/product.dart';
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
    final homeManager = context.watch<HomeManager>();

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
      onLongPress: homeManager.editing
          ? () {
              showDialog(
                context: context,
                builder: (context) {
                  final product = context
                      .read<ProductManager>()
                      .findProductById(item.productId);

                  return AlertDialog(
                    title: Text("Edit Item"),
                    content: product != null
                        ? ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Image.network(product.images.first),
                            title: Text(product.title),
                            subtitle: Text(
                                'R\$ ${product.basePrice.toStringAsFixed(2)}'),
                          )
                        : null,
                    actions: [
                      TextButton(
                        child: Text(
                          "Delete",
                          style: TextStyle(color: Colors.red),
                        ),
                        onPressed: () {
                          print(item);
                          context.read<Section>().removeitem(item);
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text(product != null ? "unbind" : "Link"),
                        onPressed: () async {
                          if (product != null) {
                            item.productId = null;
                          } else {
                            final Product product = await Navigator.of(context)
                                    .pushNamed(SelectProductScreen.routeName)
                                as Product;
                            item.productId = product.id;
                          }
                        },
                      )
                    ],
                  );
                },
              );
            }
          : null,
      child: AspectRatio(
        aspectRatio: 1,
        child: item.image is String
            ? FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: item.image,
                fit: BoxFit.cover,
              )
            : Image.file(
                item.image as File,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}

class AddTileWidget extends StatelessWidget {
  const AddTileWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final section = context.watch<Section>();

    void onImageSelected(File file) {
      section.addItem(SectionItem(image: file));
      Navigator.of(context).pop();
    }

    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        child: Container(
          color: Colors.white.withAlpha(30),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        onTap: () {
          if (Platform.isAndroid) {
            showModalBottomSheet(
              context: context,
              builder: (context) =>
                  ImageSourceSheet(onSelectedImage: onImageSelected),
            );
          } else {
            showCupertinoModalPopup(
              context: context,
              builder: (context) =>
                  ImageSourceSheet(onSelectedImage: onImageSelected),
            );
          }
        },
      ),
    );
  }
}
