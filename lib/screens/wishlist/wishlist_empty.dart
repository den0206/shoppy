import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/Extension/CostomWidgets.dart';
import 'package:shoppy/Provider/dark_theme_provider.dart';
import 'package:shoppy/consts/colors.dart';

class EmptyWishList extends StatelessWidget {
  const EmptyWishList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 80),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/empty-wishlist.png"),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Text(
          "Your Wishlist List",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          "Explore more and shortlist some items",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w600,
            color: theme.darkMode
                ? Theme.of(context).disabledColor
                : ColorsConsts.subTitle,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.06,
          child: CustomButton(
            title: "Add awish",
            backColor: Colors.red,
            onPressed: () {},
          ),
        )
      ],
    );
  }
}
