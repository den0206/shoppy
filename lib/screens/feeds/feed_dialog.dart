import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/consts/colors.dart';
import 'package:shoppy/consts/my_icons.dart';
import 'package:shoppy/model/product.dart';
import 'package:shoppy/provider/cart_provider.dart';
import 'package:shoppy/provider/wishlist_provider.dart';
import 'package:shoppy/screens/product_details.dart';

class FeedDialog extends StatelessWidget {
  const FeedDialog({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    final wishProvider = context.watch<WishlistProvider>();
    final cartProvider = context.watch<CartProvider>();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              constraints: BoxConstraints(
                minHeight: 100,
                maxHeight: MediaQuery.of(context).size.height * 0.5,
              ),
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor),
              child: Image.network(product.imageUrl),
            ),
            Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DialogContent(
                    icon: Icon(
                      wishProvider.favItems.contains(product)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                      size: 25,
                    ),
                    text: wishProvider.favItems.contains(product)
                        ? 'In wishlist'
                        : 'Add to wishlist',
                    ontap: () {
                      wishProvider.addAndRemoveFav(product);
                      if (Navigator.canPop(context)) Navigator.pop(context);
                    },
                  ),
                  DialogContent(
                    icon: Icon(
                      Feather.eye,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                      size: 25,
                    ),
                    text: 'View product',
                    ontap: () {
                      Navigator.of(context)
                          .pushNamed(
                            DetailProductPage.routeName,
                            arguments: product,
                          )
                          .then((value) => Navigator.canPop(context)
                              ? Navigator.pop(context)
                              : null);
                    },
                  ),
                  DialogContent(
                    icon: Icon(
                      MyAppIcons.cart,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                      size: 25,
                    ),
                    text: cartProvider.cartItems.containsKey(product.id)
                        ? "In Cart"
                        : "Add to Cart",
                    ontap: () {
                      cartProvider.addTocart(product);
                      if (Navigator.canPop(context)) Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 1.3,
                ),
                shape: BoxShape.circle,
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  splashColor: Colors.grey,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.close,
                      size: 28,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () =>
                      Navigator.canPop(context) ? Navigator.pop(context) : null,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DialogContent extends StatelessWidget {
  const DialogContent({
    Key key,
    this.text,
    this.icon,
    this.ontap,
  }) : super(key: key);

  final String text;
  final Icon icon;
  final Function() ontap;

  @override
  Widget build(BuildContext context) {
    // final theme = Provider.of<ThemeProvider>(context);

    return Flexible(
      child: FittedBox(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: ontap,
            splashColor: Colors.grey,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.25,
              padding: EdgeInsets.all(4),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                          offset: const Offset(0.0, 10.0),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: icon,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: FittedBox(
                      child: Text(
                        text,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: ColorsConsts.subTitle,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
