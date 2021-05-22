import 'package:flutter/material.dart';
import 'package:shoppy/screens/wishlist/wishlist_cell.dart';
import 'package:shoppy/screens/wishlist/wishlist_empty.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({Key key}) : super(key: key);
  static const routeName = '/WishListScreen';

  @override
  Widget build(BuildContext context) {
    List wishList = ["a"];
    return Scaffold(
      appBar: AppBar(
        title: Text("WishList"),
      ),
      body: wishList.isEmpty
          ? EmptyWishList()
          : ListView.builder(
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return WishListCell();
              },
            ),
    );
  }
}
