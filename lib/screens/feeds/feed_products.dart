import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:shoppy/screens/product_details.dart';

class FeedProducts extends StatelessWidget {
  const FeedProducts({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(DetailProductPage.routeName);
          // navigateTo(context, DetailProductPage.routeName);
        },
        child: Container(
          width: 250,
          height: 290,
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(8),
            color: Theme.of(context).backgroundColor,
          ),
          child: Column(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: Container(
                          width: double.infinity,
                          constraints: BoxConstraints(
                            minHeight: 100,
                            maxHeight: MediaQuery.of(context).size.height * 0.3,
                          ),
                          child: Image.network(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4PdHtXka2-bDDww6Nuect3Mt9IwpE4v4HNw&usqp=CAU',
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 5,
                        top: 5,
                        child: Badge(
                          alignment: Alignment.center,
                          toAnimate: true,
                          shape: BadgeShape.square,
                          badgeColor: Colors.pink,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(8),
                          ),
                          badgeContent: Text(
                            "New",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 5),
                margin: EdgeInsets.only(left: 5, bottom: 2, right: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Descriptipn",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        '\$ 158.99',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Quantity 12",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(18),
                            child: Icon(Icons.more_horiz, color: Colors.grey),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
