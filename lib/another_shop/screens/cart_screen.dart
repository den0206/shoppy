import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/Extension/CostomWidgets.dart';
import 'package:shoppy/another_shop/common/login_card.dart';
import 'package:shoppy/another_shop/provider/cart_manager.dart';
import 'package:shoppy/another_shop/screens/empty_card.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key key}) : super(key: key);
  static const routeName = '/CartScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        centerTitle: true,
      ),
      body: Consumer<CartManager>(
        builder: (_, model, __) {
          if (model.user == null) {
            return LoginCard();
          }
          if (model.items.isEmpty) {
            return EmptyCard(
              iconData: Icons.remove_shopping_cart,
              title: "Empty Cart!",
            );
          }
          return ListView(
            children: [
              Column(
                children:
                    model.items.map((c) => CartTile(cartProduct: c)).toList(),
              ),
              PriceCard(
                buttonTitle: "Go Cart",
                onTap: model.isCartValid ? () {} : null,
              )
            ],
          );
        },
      ),
    );
  }
}

class CartTile extends StatelessWidget {
  const CartTile({Key key, this.cartProduct}) : super(key: key);

  final CartProduct cartProduct;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: cartProduct,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: Image.network(cartProduct.product.imageUrl),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cartProduct.product.title,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          "Size : ${cartProduct.size}",
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ),
                      Consumer<CartProduct>(builder: (_, model, __) {
                        if (model.hasStock) {
                          return Text(
                            'R\$ ${cartProduct.unitPrice.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        } else {
                          return Text(
                            "Sold out",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          );
                        }
                      })
                    ],
                  ),
                ),
              ),
              Consumer<CartProduct>(builder: (_, model, __) {
                return Column(
                  children: [
                    CircleiconButton(
                      iconData: Icons.add,
                      color: Theme.of(context).primaryColor,
                      onTap: model.increment,
                    ),
                    Text(
                      "${cartProduct.quantity}",
                      style: TextStyle(fontSize: 20),
                    ),
                    CircleiconButton(
                      iconData: Icons.remove,
                      color: model.quantity > 1
                          ? Theme.of(context).primaryColor
                          : Colors.red,
                      onTap: model.decrement,
                    ),
                  ],
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}

class PriceCard extends StatelessWidget {
  const PriceCard({
    Key key,
    @required this.buttonTitle,
    @required this.onTap,
  }) : super(key: key);
  final String buttonTitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cartManager = context.watch<CartManager>();
    final productPrice = cartManager.productsPrice.toStringAsFixed(2);
    final deliveryPrice = cartManager.deliverPrice;
    final totalPrice = cartManager.totalPrice;

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Price",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Sub Total"),
                Text("R\$ $productPrice"),
              ],
            ),
            Divider(),
            if (deliveryPrice != null) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Deliver price"),
                  Text('R\$ ${deliveryPrice.toStringAsFixed(2)}')
                ],
              ),
            ],
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "R\$ ${totalPrice.toStringAsFixed(2)}",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  textStyle: TextStyle(
                    color: Colors.white,
                  )),
              onPressed: onTap,
              child: Text(
                buttonTitle,
              ),
            )
          ],
        ),
      ),
    );
  }
}
