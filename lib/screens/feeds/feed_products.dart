import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:shoppy/model/product.dart';
import 'package:shoppy/screens/product_details.dart';

class FeedProducts extends StatelessWidget {
  const FeedProducts({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed(DetailProductPage.routeName, arguments: product);
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
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.25,
                          ),
                          child: Image.network(
                            product.imageUrl,
                            fit: BoxFit.fill,
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
                      "${product.description}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        '\$ ${product.price}',
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
                          "${product.quantity}",
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
