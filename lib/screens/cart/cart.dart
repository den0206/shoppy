import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/Extension/global_function.dart';
import 'package:shoppy/consts/colors.dart';
import 'package:shoppy/consts/my_icons.dart';
import 'package:shoppy/consts/service/stripe_service.dart';
import 'package:shoppy/provider/cart_provider.dart';
import 'package:shoppy/screens/cart/cart_Widgets.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key key}) : super(key: key);

  static const routeName = '/CartScreen';

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cartItems;

    return Scaffold(
      bottomSheet: cartItems.isEmpty
          ? null
          : ChangeNotifierProvider.value(
              value: CheckoutSectionModel(),
              child: _CheckoutSection(),
            ),
      appBar: cartItems.isEmpty
          ? null
          : AppBar(
              title: Text('${cartProvider.totalCount}'),
              actions: [
                IconButton(
                  icon: Icon(MyAppIcons.trash),
                  onPressed: () {
                    showAlert(
                      context,
                      "Remove All",
                      "Would you liket Clear cart?",
                      () => cartProvider.clearCart(),
                    );
                  },
                )
              ],
            ),
      body: cartItems.isEmpty
          ? EmptyCart()
          : Container(
              margin: EdgeInsets.only(bottom: 60),
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final carAttr = cartItems.values.toList()[index];
                  return FullCart(cartAttr: carAttr);
                },
              ),
            ),
    );
  }
}

class CheckoutSectionModel with ChangeNotifier {
  CheckoutSectionModel() {
    StripeService.init();
  }

  void payWithCard({
    int amount,
    Function() onSuccess,
  }) async {
    await Future.delayed(Duration(seconds: 5));
    print(amount);
    onSuccess();

    // var response = await StripeService.payWithNewCard("USD", amount.toString());
    // print(response.message);
  }
}

class _CheckoutSection extends StatelessWidget {
  const _CheckoutSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalAmmount = Provider.of<CartProvider>(context).totalAmount;
    final model = context.watch<CheckoutSectionModel>();

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
                    onTap: () async {
                      double amountInCents = totalAmmount * 1000;
                      int intengerAmount = (amountInCents / 10).ceil();

                      ProgressDialog dialog = ProgressDialog(context);
                      dialog.style(message: "Pleaser wait...");

                      await dialog.show();

                      model.payWithCard(
                        amount: intengerAmount,
                        onSuccess: () async {
                          await dialog.hide();

                          showAlert(
                              context, "Success", "Patment Succes", () {});
                        },
                      );
                    },
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
              "Sum \$${totalAmmount.toStringAsFixed(2)}",
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
