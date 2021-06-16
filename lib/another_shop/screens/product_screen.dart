import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/another_shop/screens/components/size_widgets.dart';
import 'package:shoppy/another_shop/screens/edit_product_screen.dart';
import 'package:shoppy/model/product.dart';
import 'package:shoppy/provider/userState.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key key, this.product}) : super(key: key);
  static const routeName = "/ProductScreen";

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            product.title,
          ),
          centerTitle: true,
          actions: [
            if (adminEnable && !product.deleted)
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // Navigator.of(context).pushReplacementNamed(
                  //     EditProductScreen.routeName,
                  //     arguments: product);

                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return EditProductScreen(
                        product: product,
                      );
                    },
                  ));
                },
              )
          ],
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: product.images != null
                  ? Carousel(
                      images: product.images.map((url) {
                        return CachedNetworkImageProvider(url);
                      }).toList(),
                      dotSize: 4,
                      dotSpacing: 15,
                      dotBgColor: Colors.transparent,
                      dotColor: Theme.of(context).primaryColor,
                      autoplay: false,
                    )
                  : Container(),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    product.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      "Price",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Text(
                    'R\$ 19.99',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    product.description,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  if (product.deleted)
                    Padding(
                      padding: EdgeInsets.only(top: 16, bottom: 8),
                      child: Text(
                        "This Product deleted",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                        ),
                      ),
                    )
                  else ...[
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text(
                        "Sizes",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: product.sizes.map((s) {
                        return SizeWidget(size: s);
                      }).toList(),
                    ),
                  ],
                  SizedBox(
                    height: 20,
                  ),
                  if (product.hasStock)
                    SizedBox(
                      height: 44,
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
