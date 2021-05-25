import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/consts/colors.dart';
import 'package:shoppy/model/product.dart';
import 'package:shoppy/provider/wishlist_provider.dart';

class WishListCell extends StatelessWidget {
  const WishListCell({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          margin: EdgeInsets.only(right: 30, bottom: 10),
          child: Material(
            color: Theme.of(context).backgroundColor,
            elevation: 3.0,
            child: InkWell(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      height: 80,
                      child: Image.network(
                        product.imageUrl,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "\$ ${product.price}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 20,
          right: 15,
          child: Container(
            height: 30,
            width: 30,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              padding: EdgeInsets.all(0),
              color: ColorsConsts.favColor,
              child: Icon(
                Icons.clear,
                color: Colors.white,
              ),
              onPressed: () =>
                  context.read<WishlistProvider>().removeItem(product),
            ),
          ),
        ),
      ],
    );
  }
}
