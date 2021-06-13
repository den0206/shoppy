import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/another_shop/common/custom_drawer.dart';
import 'package:shoppy/another_shop/provider/admin_order_manager.dart';
import 'package:shoppy/another_shop/screens/empty_card.dart';
import 'package:shoppy/another_shop/screens/order_screen.dart';

class AdminOrderScreen extends StatelessWidget {
  const AdminOrderScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Order List'),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: Consumer<AdminOrderManager>(
        builder: (_, model, __) {
          if (model.allOrders.isEmpty) {
            return EmptyCard(
              title: "No Orders",
              iconData: Icons.border_clear,
            );
          }
          return ListView.builder(
            itemCount: model.allOrders.length,
            itemBuilder: (BuildContext context, int index) {
              return OrderTile(
                order: model.allOrders.reversed.toList()[index],
              );
            },
          );
        },
      ),
    );
  }
}
