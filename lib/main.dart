import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/Provider/dark_theme_provider.dart';
import 'package:shoppy/provider/cart_provider.dart';
import 'package:shoppy/provider/products_provider.dart';
import 'package:shoppy/screens/bottom_bar.dart';
import 'package:shoppy/screens/brandRails/brand_rails.dart';
import 'package:shoppy/screens/cart/cart.dart';
import 'package:shoppy/screens/feeds/category_feeds.dart';
import 'package:shoppy/screens/feeds/feeds.dart';
import 'package:shoppy/screens/product_details.dart';
import 'package:shoppy/screens/wishlist/wishlist.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider<BottomBarModel>(
          create: (context) => BottomBarModel(),
        ),
        ChangeNotifierProvider<ProductsProvider>(
          create: (context) => ProductsProvider(),
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (context) => CartProvider(),
        )
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeData, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: themeData.buildTheme(),
            routes: {
              CartScreen.routeName: (context) => CartScreen(),
              Feeds.routeName: (context) => Feeds(),
              WishListScreen.routeName: (context) => WishListScreen(),
              BrandNavigationRail.routeName: (context) => BrandNavigationRail(),
              DetailProductPage.routeName: (context) => DetailProductPage(),
              CategoryFeeds.routeName: (context) => CategoryFeeds(),
            },
            home: BottomBarScreen(),
          );
        },
      ),
    );
  }
}
