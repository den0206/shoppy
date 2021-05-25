import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/Extension/CostomWidgets.dart';
import 'package:shoppy/consts/my_icons.dart';
import 'package:shoppy/provider/wishlist_provider.dart';
import 'package:shoppy/screens/wishlist/wishlist_cell.dart';
import 'package:shoppy/screens/wishlist/wishlist_empty.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({Key key}) : super(key: key);
  static const routeName = '/WishListScreen';

  @override
  Widget build(BuildContext context) {
    final wishList = Provider.of<WishlistProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("WishList"),
        actions: [
          if (wishList.favItems.isNotEmpty)
            IconButton(
              icon: Icon(MyAppIcons.trash),
              onPressed: () {
                showAlert(
                  context,
                  "Clear wishlist!",
                  "Your wishlist will be cleared",
                  () {
                    wishList.clearItems();
                  },
                );
              },
            )
        ],
      ),
      body: wishList.favItems.isEmpty
          ? EmptyWishList()
          : ListView.builder(
              itemCount: wishList.favItems.length,
              itemBuilder: (BuildContext context, int index) {
                return WishListCell(
                  product: wishList.favItems[index],
                );
              },
            ),
    );
  }
}
