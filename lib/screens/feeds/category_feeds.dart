import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/model/category.dart';
import 'package:shoppy/provider/products_provider.dart';
import 'package:shoppy/screens/feeds/feed_products.dart';

class CategoryFeeds extends StatelessWidget {
  const CategoryFeeds({Key key}) : super(key: key);
  static const routeName = '/CategoryFeedsScreen';

  @override
  Widget build(BuildContext context) {
    final KCategory category = ModalRoute.of(context).settings.arguments;
    final productsProvider = Provider.of<ProductsProvider>(context);

    final categoryList = productsProvider.findByCategory(category);

    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 240 / 420,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        children: List.generate(categoryList.length, (index) {
          return FeedProducts(
            product: categoryList[index],
          );
        }),
      ),
    );
  }
}
