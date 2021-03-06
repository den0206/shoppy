import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/Extension/global_function.dart';
import 'package:shoppy/another_shop/model/credit_card.dart';
import 'package:shoppy/another_shop/provider/cart_manager.dart';
import 'package:shoppy/another_shop/provider/checkout_manager.dart';
import 'package:shoppy/another_shop/screens/cart_screen.dart';
import 'package:shoppy/another_shop/screens/components/credit_card_widget.dart';
import 'package:shoppy/another_shop/screens/confirmation_screen.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({Key key}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>(debugLabel: '_ChekoutState');
  final CreditCard creditCard = CreditCard();

  static const routeName = '/CheckoutScreen';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<CartManager, CheckoutManager>(
      create: (context) => CheckoutManager(),
      update: (context, cartManager, checkoutManager) =>
          checkoutManager..updateCart(cartManager),
      lazy: false,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text('Chekout'),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Consumer<CheckoutManager>(builder: (_, model, __) {
            if (model.loading) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Progress Order...",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              );
            }
            return Form(
              key: _formKey,
              child: ListView(
                children: [
                  CreditCardWidget(
                    creditCard: creditCard,
                  ),
                  PriceCard(
                    buttonTitle: "Chekout button",
                    onTap: () {
                      model.checkout(
                        onStockFail: (e) {
                          showErrorAlert(context, e);
                        },
                        onSuccess: (order) {
                          if (_formKey.currentState.validate()) {
                            print("Success");

                            Navigator.of(context).pushNamed(
                                ConfirmationScreen.routeName,
                                arguments: order);
                            // Navigator.of(context).popUntil(
                            //     (route) => route.settings.name == BaseScreen.routeName);
                          }
                        },
                        creditCard: creditCard,
                      );
                    },
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
