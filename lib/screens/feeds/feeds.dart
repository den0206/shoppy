import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/Extension/global_function.dart';
import 'package:shoppy/consts/colors.dart';
import 'package:shoppy/consts/my_icons.dart';
import 'package:shoppy/consts/sample_products.dart';
import 'package:shoppy/model/product.dart';
import 'package:shoppy/provider/cart_provider.dart';
import 'package:shoppy/provider/products_provider.dart';
import 'package:shoppy/provider/wishlist_provider.dart';
import 'package:shoppy/screens/cart/cart.dart';
import 'package:shoppy/screens/feeds/feed_products.dart';
import 'package:shoppy/screens/wishlist/wishlist.dart';

class Feeds extends StatelessWidget {
  const Feeds({Key key}) : super(key: key);
  static const routeName = '/FeedsScreen';

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsProvider>(context).products;

    return Scaffold(
      appBar: AppBar(
        title: Text("Feeds"),
        actions: [
          Consumer<WishlistProvider>(
            builder: (context, wishlist, child) {
              return Badge(
                badgeColor: ColorsConsts.cartBadgeColor,
                animationType: BadgeAnimationType.slide,
                toAnimate: true,
                position: BadgePosition.topEnd(top: 5, end: 7),
                badgeContent: Text(
                  wishlist.favItems.length.toString(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                child: IconButton(
                  icon: Icon(
                    MyAppIcons.wishlist,
                    color: ColorsConsts.favColor,
                  ),
                  onPressed: () {
                    navigateTo(context, WishListScreen.routeName);
                  },
                ),
              );
            },
          ),
          Consumer<CartProvider>(
            builder: (context, cart, child) {
              return Badge(
                badgeColor: ColorsConsts.cartBadgeColor,
                animationType: BadgeAnimationType.slide,
                toAnimate: true,
                position: BadgePosition.topEnd(top: 5, end: 7),
                badgeContent: Text(
                  cart.totalCount.toString(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                child: IconButton(
                  icon: Icon(MyAppIcons.cart, color: ColorsConsts.cartColor),
                  onPressed: () {
                    navigateTo(context, CartPage.routeName);
                  },
                ),
              );
            },
          ),
        ],
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
