import 'package:flutter/material.dart';
import 'package:shoppy/model/category.dart';

class CategoryFeeds extends StatelessWidget {
  const CategoryFeeds({Key key}) : super(key: key);
  static const routeName = '/CategoryFeedsScreen';

  @override
  Widget build(BuildContext context) {
    final KCategory category = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Title'),
      ),
      body: Center(
        child: Text(category.name),
      ),
    );
  }
}
