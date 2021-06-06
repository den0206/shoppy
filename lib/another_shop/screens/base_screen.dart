import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/another_shop/Common/custom_drawer.dart';
import 'package:shoppy/another_shop/provider/page_manager.dart';
import 'package:shoppy/another_shop/screens/home_screen.dart';
import 'package:shoppy/another_shop/screens/products_screen.dart';
import 'package:shoppy/provider/userState.dart';

class BaseScreen extends StatelessWidget {
  BaseScreen({Key key}) : super(key: key);
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => PageManager(pageController),
      child: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          HomeScreen(),
          ProductsScreen(),
          Scaffold(
            appBar: AppBar(
              title: Text('Home3'),
            ),
            drawer: CustomDrawer(),
          ),
          Scaffold(
            appBar: AppBar(
              title: Text('Home4'),
            ),
            drawer: CustomDrawer(),
          ),
          if (adminEnable) ...[
            Scaffold(
              appBar: AppBar(
                title: Text('Setting'),
              ),
              drawer: CustomDrawer(),
            ),
            Scaffold(
              appBar: AppBar(
                title: Text('Setting2'),
              ),
              drawer: CustomDrawer(),
            ),
          ]
        ],
      ),
    );
  }
}
