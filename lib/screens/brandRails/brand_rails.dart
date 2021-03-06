import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/model/popular_brand.dart';
import 'package:shoppy/provider/products_provider.dart';
import 'package:shoppy/screens/brandRails/brand_cell.dart';

class BrandNavigationModel extends ChangeNotifier {
  int _currentIndex;
  int get currentIndex => _currentIndex;

  BrandNavigationModel(int current) {
    _currentIndex = current;
  }

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}

class BrandNavigationRail extends StatelessWidget {
  const BrandNavigationRail({Key key}) : super(key: key);
  static const routeName = '/brands_navigation_rail';

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments;

    return ChangeNotifierProvider<BrandNavigationModel>(
      create: (context) => BrandNavigationModel(routeArgs),
      builder: (context, snapshot) {
        return Consumer<BrandNavigationModel>(builder: (context, model, child) {
          final brand = brands[model._currentIndex];

          return Scaffold(
            appBar: AppBar(
              title: Text(brand.name),
            ),
            body: Row(
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: constraints.maxHeight),
                        child: IntrinsicHeight(
                          child: NavigationRail(
                            minWidth: 56,
                            groupAlignment: 1,
                            selectedIndex: model.currentIndex,
                            onDestinationSelected: model.setIndex,
                            labelType: NavigationRailLabelType.all,
                            leading: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: CircleAvatar(
                                    radius: 16,
                                    backgroundImage: NetworkImage(
                                      "https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg",
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 80,
                                )
                              ],
                            ),
                            selectedLabelTextStyle: TextStyle(
                              color: Color(0xffffe6bc97),
                              fontSize: 20,
                              letterSpacing: 1,
                              decoration: TextDecoration.underline,
                              decorationThickness: 2.5,
                            ),
                            unselectedLabelTextStyle: TextStyle(
                              fontSize: 15,
                              letterSpacing: 0.8,
                            ),
                            destinations: [
                              for (int i = 0; i < brands.length; i++)
                                buildRotatedTextRailDestination(brands[i]),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                BrandSpace(brand: brand)
              ],
            ),
          );
        });
      },
    );
  }

  NavigationRailDestination buildRotatedTextRailDestination(
    Brand brand,
  ) {
    final padding = 8.0;
    return NavigationRailDestination(
      icon: SizedBox.shrink(),
      label: Padding(
        padding: EdgeInsets.symmetric(vertical: padding),
        child: RotatedBox(
          quarterTurns: -1,
          child: brand != null ? Text(brand.name) : Text("All"),
        ),
      ),
    );
  }
}

class BrandSpace extends StatelessWidget {
  const BrandSpace({
    Key key,
    @required this.brand,
  }) : super(key: key);

  final Brand brand;

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final brandList = brand != Brand.all
        ? productsProvider.fibdByBrand(brand)
        : productsProvider.products;

    return Expanded(
      child: Padding(
        padding: EdgeInsets.fromLTRB(24, 8, 0, 0),
        child: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: ListView.builder(
            itemCount: brandList.length,
            itemBuilder: (context, index) {
              return BrandCell(product: brandList[index]);
            },
          ),
        ),
      ),
    );
  }
}
