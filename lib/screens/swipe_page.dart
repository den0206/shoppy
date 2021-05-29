import 'package:flutter/material.dart';
import 'package:shoppy/screens/bottom_bar.dart';
import 'package:shoppy/screens/upload_product_page.dart';

class SwipePage extends StatelessWidget {
  const SwipePage({Key key}) : super(key: key);

  static const routeName = '/SwipePage';

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [BottomBarScreen(), UploadProductPage()],
    );
  }
}
