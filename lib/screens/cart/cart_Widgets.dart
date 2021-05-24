import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/Extension/CostomWidgets.dart';
import 'package:shoppy/Provider/dark_theme_provider.dart';
import 'package:shoppy/consts/colors.dart';
import 'package:shoppy/model/cart_attr.dart';
import 'package:shoppy/provider/cart_provider.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 80),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/emptycart.png"),
            ),
          ),
        ),
        Text(
          "Your Cart Is Empty",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).textSelectionTheme.selectionColor,
            fontSize: 36,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          'Looks Like You didn\'t \n add anything to your cart yet',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        CustomButton(
          backColor: Colors.redAccent,
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.06,
          title: 'Shop now'.toUpperCase(),
          onPressed: () {},
        )
      ],
    );
  }
}

class FullCart extends StatelessWidget {
  const FullCart({
    Key key,
    @required this.cartAttr,
  }) : super(key: key);
  final CartAttr cartAttr;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    double subTotal = cartAttr.product.price * cartAttr.quantity;

    return Container(
      height: 135,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: Colors.grey,
      ),
      child: Row(
        children: [
          Container(
            width: 130,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(cartAttr.product.imageUrl),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.all(2),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          cartAttr.product.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(32),
                          onTap: () {},
                          child: Container(
                            height: 50,
                            width: 50,
                            child: Icon(
                              Entypo.cross,
                              color: Colors.red,
                              size: 22,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text("Price:"),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${cartAttr.product.price}\$',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text("Sub Total:"),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${subTotal.toStringAsFixed(2)}\$',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: theme.darkMode
                              ? Colors.brown.shade900
                              : Theme.of(context).accentColor,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Ship Free",
                        style: TextStyle(
                          color: theme.darkMode
                              ? Colors.brown.shade600
                              : Theme.of(context).accentColor,
                        ),
                      ),
                      Spacer(),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(4),
                          onTap: () {
                            /// reduce
                            cartProvider.reduceItemByOne(cartAttr.product);
                          },
                          child: Container(
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Icon(
                                Entypo.minus,
                                color: Colors.red,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 12,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.12,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                ColorsConsts.gradiendLStart,
                                ColorsConsts.gradiendLEnd,
                              ],
                              stops: [0.0, 0.7],
                            ),
                          ),
                          child: Text(
                            "${cartAttr.quantity}",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(4),
                          onTap: () {
                            /// add
                            cartProvider.addTocart(cartAttr.product);
                          },
                          child: Container(
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Icon(
                                Entypo.plus,
                                color: Colors.green,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
