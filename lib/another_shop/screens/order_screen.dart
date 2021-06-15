import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/another_shop/common/custom_drawer.dart';
import 'package:shoppy/another_shop/common/login_card.dart';
import 'package:shoppy/another_shop/model/order.dart';
import 'package:shoppy/another_shop/provider/cart_manager.dart';
import 'package:shoppy/another_shop/provider/order_manager.dart';
import 'package:shoppy/another_shop/screens/components/order_tile_dialog.dart';
import 'package:shoppy/another_shop/screens/empty_card.dart';
import 'package:shoppy/another_shop/screens/product_screen.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('Orders'),
        centerTitle: true,
      ),
      body: Consumer<OrderManager>(
        builder: (_, model, __) {
          if (model.user == null) {
            return LoginCard();
          }
          if (model.orders.isEmpty) {
            return EmptyCard(
              title: "No Orders",
              iconData: Icons.border_clear,
            );
          }

          return ListView.builder(
            itemCount: model.orders.length,
            itemBuilder: (_, index) {
              return OrderTile(
                order: model.orders.reversed.toList()[index],
                showControls: true,
              );
            },
          );
        },
      ),
    );
  }
}

class OrderTile extends StatelessWidget {
  const OrderTile({
    Key key,
    this.order,
    this.showControls = false,
  }) : super(key: key);

  final Order order;
  final bool showControls;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
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
            Text(
              order.status.message,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: order.status == OrderStatus.cancel
                    ? Colors.red
                    : Theme.of(context).primaryColor,
                fontSize: 14,
              ),
            )
          ],
        ),
        children: [
          Column(
            children: order.items.map((c) {
              return OrderProductTile(cartProduct: c);
            }).toList(),
          ),
          if (showControls && order.status != OrderStatus.cancel)
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  TextButton(
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) =>
                              CancelOrderDialog(order: order));
                    },
                  ),
                  TextButton(
                    child: Text("Back"),
                    onPressed: order.back,
                  ),
                  TextButton(
                    child: Text("Advance"),
                    onPressed: order.advance,
                  ),
                  TextButton(
                    child: Text("End"),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) =>
                              ExportAddressDialog(address: order.address));
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class OrderProductTile extends StatelessWidget {
  const OrderProductTile({
    Key key,
    this.cartProduct,
  }) : super(key: key);

  final CartProduct cartProduct;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return ProductScreen(
                product: cartProduct.product,
              );
            },
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            SizedBox(
              height: 60,
              width: 60,
              child: Image.network(
                cartProduct.product.images.first,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
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
                  Text(
                    "${cartProduct.size}",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'R\$ ${(cartProduct.fixedPrice ?? cartProduct.unitPrice).toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            Text(
              "${cartProduct.quantity}",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
