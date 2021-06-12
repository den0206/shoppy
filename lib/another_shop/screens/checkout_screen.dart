import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/another_shop/provider/cart_manager.dart';
import 'package:shoppy/another_shop/provider/checkout_manager.dart';
import 'package:shoppy/another_shop/screens/cart_screen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key key}) : super(key: key);

  static const routeName = '/CheckoutScreen';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<CartManager, CheckoutManager>(
      create: (context) => CheckoutManager(),
      update: (context, cartManager, checkoutManager) =>
          checkoutManager..updateCart(cartManager),
      lazy: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Chekout'),
        ),
        body: Consumer<CheckoutManager>(builder: (_, model, __) {
          return ListView(
            children: [
              PriceCard(
                buttonTitle: "Chekout button",
                onTap: () {
                  model.checkout();
                },
              )
            ],
          );
        }),
      ),
    );
  }
}
