import 'package:flutter/material.dart';
import 'package:shoppy/another_shop/model/order.dart';
import 'package:shoppy/another_shop/screens/order_screen.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({Key key, this.order}) : super(key: key);

  static const routeName = '/ConfirmationScreen';

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Confirmation'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(16),
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.formatterId,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Text(
                      'R\$ ${order.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              ),
              Column(
                children: order.items.map((c) {
                  return OrderProductTile(cartProduct: c);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
