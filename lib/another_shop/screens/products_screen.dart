import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/another_shop/common/custom_drawer.dart';
import 'package:shoppy/another_shop/provider/product_manager.dart';
import 'package:shoppy/another_shop/screens/cart_screen.dart';
import 'package:shoppy/another_shop/screens/edit_product_screen.dart';
import 'package:shoppy/another_shop/screens/product_screen.dart';
import 'package:shoppy/model/product.dart';
import 'package:shoppy/provider/userState.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<ProductManager>(
          builder: (_, model, __) {
            if (model.searchText.isEmpty) {
              return Text(("Products"));
            } else {
              return LayoutBuilder(
                builder: (_, constraints) {
                  return GestureDetector(
                    onTap: () async {
                      final searchText = await showDialog<String>(
                        context: context,
                        builder: (context) => SearchDialog(
                          initialtext: model.searchText,
                        ),
                      );

                      /// get dialog String
                      if (searchText != null) {
                        print(searchText);
                        model.searchText = searchText;
                      }
                    },
                    child: Container(
                      width: constraints.biggest.width,
                      child: Text(
                        model.searchText,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
        centerTitle: true,
        actions: [
          Consumer<ProductManager>(
            builder: (context, model, child) {
              if (model.searchText.isEmpty) {
                return IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    final searchText = await showDialog<String>(
                      context: context,
                      builder: (context) =>
                          SearchDialog(initialtext: model.searchText),
                    );

                    /// get dialog String
                    if (searchText != null) {
                      print(searchText);
                      model.searchText = searchText;
                    }
                  },
                );
              } else {
                return IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () async {
                    model.searchText = "";
                  },
                );
              }
            },
          ),
          if (adminEnable)
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return EditProductScreen();
                  },
                ));
              },
            )
        ],
      ),
      drawer: CustomDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.of(context).pushNamed(CartScreen.routeName);
        },
        child: Icon(Icons.shopping_cart),
      ),
      body: Consumer<ProductManager>(
        builder: (context, model, child) {
          return ListView.builder(
            padding: EdgeInsets.all(4),
            itemCount: sampleProducts.length,
            // itemCount: model.filterdProducts.length,
            itemBuilder: (BuildContext context, int index) {
              return ProductListTile(product: sampleProducts[index]);
            },
          );
        },
      ),
    );
  }
}

class ProductListTile extends StatelessWidget {
  const ProductListTile({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductScreen(
            product: product,
          ),
        ));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Container(
          height: 100,
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: CachedNetworkImage(imageUrl: product.imageUrl),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      "aaa",
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Text(
                    "R\$ 19.99",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class SearchDialog extends StatelessWidget {
  const SearchDialog({
    Key key,
    @required this.initialtext,
  }) : super(key: key);

  final String initialtext;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 2,
          left: 4,
          right: 4,
          child: Card(
            child: TextFormField(
              initialValue: initialtext,
              textInputAction: TextInputAction.search,
              autofocus: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 15),
                prefixIcon: IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Colors.grey[700],
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              onFieldSubmitted: (text) {
                Navigator.of(context).pop(text);
              },
            ),
          ),
        )
      ],
    );
  }
}
