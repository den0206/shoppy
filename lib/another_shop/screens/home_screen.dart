import 'package:flutter/material.dart';
import 'package:shoppy/another_shop/common/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: Container(),
    );
  }
}
