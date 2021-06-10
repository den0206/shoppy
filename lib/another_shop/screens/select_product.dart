import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/another_shop/provider/product_manager.dart';

class SelectProductScreen extends StatelessWidget {
  const SelectProductScreen({Key key}) : super(key: key);

  static const routeName = '/SelectProduct';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Link Product'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Consumer<ProductManager>(
        builder: (context, model, child) {
          return ListView.builder(
            itemCount: model.allProduct.length,
            itemBuilder: (context, index) {
              final product = model.allProduct[index];
              return ListTile(
                leading: Image.network(product.images.first),
                title: Text(product.title),
                subtitle: Text(
                  'R\$ ${product.basePrice.toStringAsFixed(2)}',
                ),
                onTap: () {
                  Navigator.of(context).pop(product);
                },
              );
            },
          );
        },
      ),
    );
  }
}
