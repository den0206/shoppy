import 'package:flutter/material.dart';
import 'package:shoppy/consts/colors.dart';
import 'package:shoppy/consts/my_icons.dart';
import 'package:shoppy/screens/widget/Cart_Widgets.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List products = ["a"];

    return Scaffold(
      bottomSheet: products.isEmpty ? null : _CheckoutSection(),
      appBar: products.isEmpty
          ? null
          : AppBar(
              title: Text('${products.length}'),
              actions: [
                IconButton(
                  icon: Icon(MyAppIcons.trash),
                  onPressed: () {},
                )
              ],
            ),
      body: products.isEmpty
          ? EmptyCart()
          : Container(
              margin: EdgeInsets.only(bottom: 60),
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return FullCart();
                },
              ),
            ),
    );
  }
}

class _CheckoutSection extends StatelessWidget {
  const _CheckoutSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey, width: 0.5),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    colors: [
                      ColorsConsts.gradiendLStart,
                      ColorsConsts.gradiendLEnd
                    ],
                    stops: [0.0, 0.7],
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {},
                    splashColor: Theme.of(context).splashColor,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "CheckOut",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            Text(
              "Total",
              style: TextStyle(
                color: Theme.of(context).textSelectionTheme.selectionColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Sum \$179.0",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
