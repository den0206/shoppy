import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/model/product.dart';
import 'package:shoppy/provider/products_provider.dart';
import 'package:shoppy/screens/feeds/feed_products.dart';

class Feeds extends StatelessWidget {
  const Feeds({Key key}) : super(key: key);
  static const routeName = '/FeedsScreen';

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsProvider>(context).products;

    print(products.length);
    return Scaffold(
      appBar: AppBar(
        title: Text("Feeds"),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 240 / 390,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        children: List.generate(
          products.length,
          (index) {
            final product = products[index];
            return FeedProducts(
              product: product,
            );
          },
        ),
      ),
    );
  }
}

class StaggleProduct extends StatelessWidget {
  const StaggleProduct({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StaggeredGridView.countBuilder(
        addAutomaticKeepAlives: false,
        crossAxisCount: 6,
        itemCount: 8,
        mainAxisSpacing: 8,
        crossAxisSpacing: 6,
        itemBuilder: (context, index) => FeedProducts(
          product: sampleProducts[index],
        ),
        staggeredTileBuilder: (index) {
          return StaggeredTile.count(3, index.isEven ? 4 : 5);
        },
      ),
    );
  }
}
