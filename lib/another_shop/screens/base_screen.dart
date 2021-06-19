import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/another_shop/provider/page_manager.dart';
import 'package:shoppy/another_shop/screens/admin_orders_screen.dart';
import 'package:shoppy/another_shop/screens/admin_users_screen.dart';
import 'package:shoppy/another_shop/screens/home_screen.dart';
import 'package:shoppy/another_shop/screens/order_screen.dart';
import 'package:shoppy/another_shop/screens/products_screen.dart';
import 'package:shoppy/another_shop/screens/store_screen.dart';
import 'package:shoppy/provider/userState.dart';

class BaseScreen extends StatelessWidget {
  BaseScreen({Key key}) : super(key: key);
  static const routeName = '/BaseScreen';

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    print(adminEnable);
    return Provider(
      create: (context) => PageManager(pageController),
      child: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          HomeScreen(),
          ProductsScreen(),
          OrderScreen(),
          StoreScreen(),
          AdminUsersScreen(),
          AdminOrderScreen(),
        ],
      ),
    );
  }
}
