import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/Extension/CostomWidgets.dart';
import 'package:shoppy/another_shop/common/custom_drawer.dart';
import 'package:shoppy/another_shop/model/order.dart';
import 'package:shoppy/another_shop/provider/admin_order_manager.dart';
import 'package:shoppy/another_shop/screens/empty_card.dart';
import 'package:shoppy/another_shop/screens/order_screen.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AdminOrderScreen extends StatelessWidget {
  AdminOrderScreen({Key key}) : super(key: key);

  final PanelController panelController = PanelController();

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
          final filterdOrder = model.filterdOrders;

          return SlidingUpPanel(
            controller: panelController,
            minHeight: 40,
            maxHeight: 250,
            body: Column(
              children: [
                if (model.userFilter != null)
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 2),
                    child: Row(
                      children: [
                        Text(
                          "Filterd ${model.userFilter.name}",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        CircleiconButton(
                          iconData: Icons.close,
                          color: Colors.white,
                          onTap: () {
                            model.setUserFilter(null);
                          },
                        )
                      ],
                    ),
                  ),
                if (filterdOrder.isEmpty)
                  Expanded(
                    child: EmptyCard(
                      title: "No Order",
                      iconData: Icons.border_clear,
                    ),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      itemCount: filterdOrder.length,
                      itemBuilder: (_, index) {
                        return OrderTile(
                          order: filterdOrder[index],
                          showControls: true,
                        );
                      },
                    ),
                  ),
                SizedBox(
                  height: 120,
                ),
              ],
            ),
            panel: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: () {
                    if (panelController.isPanelClosed) {
                      panelController.open();
                    } else {
                      panelController.close();
                    }
                  },
                  child: Container(
                    height: 40,
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: Text(
                      "Filter",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: OrderStatus.values.map((s) {
                    return CheckboxListTile(
                      title: Text(s.message),
                      dense: true,
                      activeColor: Theme.of(context).primaryColor,
                      value: model.statusFilter.contains(s),
                      onChanged: (v) {
                        model.setUserStatusFilter(status: s, enable: v);
                      },
                    );
                  }).toList(),
                ))
              ],
            ),
          );
        },
      ),
    );
  }
}
