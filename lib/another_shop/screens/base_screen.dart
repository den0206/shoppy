import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/another_shop/Common/custom_drawer.dart';
import 'package:shoppy/another_shop/screens/product_screen.dart';

class PageManager {
  PageManager(this._pageController);
  final PageController _pageController;
  int page = 0;

  void setPage(int value) {
    if (value == page) return;
    page = value;
    _pageController.jumpToPage(value);
  }
}

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
          Scaffold(
            appBar: AppBar(
              title: Text('Home'),
            ),
            drawer: CustomDrawer(),
          ),
          ProductScreen(),
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
        ],
      ),
    );
  }
}
