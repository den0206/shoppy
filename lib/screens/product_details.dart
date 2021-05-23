import 'package:flutter/material.dart';
import 'package:shoppy/Extension/CostomWidgets.dart';
import 'package:shoppy/consts/colors.dart';
import 'package:shoppy/consts/my_icons.dart';
import 'package:shoppy/screens/cart/cart.dart';
import 'package:shoppy/screens/feeds/feed_products.dart';
import 'package:shoppy/screens/wishlist/wishlist.dart';

class DetailProductPage extends StatelessWidget {
  const DetailProductPage({Key key}) : super(key: key);
  static const routeName = '/DetailsScreen';

  @override
  Widget build(BuildContext context) {
    // final theme = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            foregroundDecoration: BoxDecoration(color: Colors.black12),
            height: MediaQuery.of(context).size.height * 0.45,
            width: double.infinity,
            child: Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4PdHtXka2-bDDww6Nuect3Mt9IwpE4v4HNw&usqp=CAU',
            ),
          ),
          SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 16, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 250,
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Material(
                        color: Colors.transparent,

                        /// icon buttn
                        child: InkWell(
                          borderRadius: BorderRadius.circular(30),
                          child: Padding(
                            padding: EdgeInsets.all(18),
                            child: Icon(
                              Icons.save,
                              size: 23,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {},
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(30),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Icon(
                              Icons.share,
                              size: 23,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Text(
                          "Title",
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "US \$15",
                        style: TextStyle(
                          color: ColorsConsts.subTitle,
                          // color: theme.darkMode
                          //     ? Theme.of(context).disabledColor
                          //     : ColorsConsts.subTitle,
                          fontWeight: FontWeight.bold,
                          fontSize: 21,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Divider(
                    thickness: 1,
                    color: Colors.grey,
                    height: 1,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "Description",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 21,
                      color: ColorsConsts.subTitle,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Divider(
                    thickness: 1,
                    color: Colors.grey,
                    height: 1,
                  ),
                ),
                _Datails(title: "Brand", info: "Brand"),
                _Datails(title: "Quantyty", info: "Quantyty"),
                _Datails(title: "Category", info: "Category"),
                _Datails(title: "Popularity", info: "Popularity"),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                  height: 1,
                ),
                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "No Review",
                          style: TextStyle(
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 21,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(2),
                        child: Text(
                          "Be The First Review",
                          style: TextStyle(
                            color: ColorsConsts.subTitle,
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                  height: 1,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(8),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Text(
                    "Suggested",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 30),
                  width: double.infinity,
                  height: 300,
                  child: ListView.builder(
                    itemCount: 7,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return FeedProducts();
                    },
                  ),
                )
              ],
            ),
          ),

          /// appBar

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Text(
                "Detail",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    MyAppIcons.wishlist,
                    color: ColorsConsts.favColor,
                  ),
                  onPressed: () {
                    navigateTo(context, WishListScreen.routeName);
                  },
                ),
                IconButton(
                  icon: Icon(MyAppIcons.cart, color: ColorsConsts.cartColor),
                  onPressed: () {
                    navigateTo(context, CartScreen.routeName);
                  },
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.red,
                    height: 70,
                    child: TextButton(
                      child: Text(
                        "Add Cart",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.green,
                    height: 70,
                    child: TextButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Buy Now",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.payment,
                            color: Colors.green.shade700,
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.grey,
                    height: 70,
                    child: TextButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            MyAppIcons.wishlist,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Datails extends StatelessWidget {
  const _Datails({
    Key key,
    @required this.title,
    @required this.info,
  }) : super(key: key);

  final String title;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15, left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).textSelectionTheme.selectionColor,
              fontWeight: FontWeight.w600,
              fontSize: 21,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            info,
            style: TextStyle(
              color: Theme.of(context).disabledColor,
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),
          )
        ],
      ),
    );
  }
}
