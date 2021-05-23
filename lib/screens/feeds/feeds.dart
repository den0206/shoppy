import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shoppy/Extension/CostomWidgets.dart';
import 'package:shoppy/screens/feeds/feed_products.dart';
import 'package:shoppy/screens/product_details.dart';

class Feeds extends StatelessWidget {
  const Feeds({Key key}) : super(key: key);
  static const routeName = '/FeedsScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feeds"),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 240 / 290,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        children: List.generate(
          100,
          (index) {
            return InkWell(
              child: FeedProducts(),
              onTap: () {
                navigateTo(context, DetailProductPage.routeName);
              },
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
        itemBuilder: (context, index) => FeedProducts(),
        staggeredTileBuilder: (index) {
          return StaggeredTile.count(3, index.isEven ? 4 : 5);
        },
      ),
    );
  }
}
