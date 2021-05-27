import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/consts/colors.dart';
import 'package:shoppy/model/product.dart';
import 'package:shoppy/provider/products_provider.dart';
import 'package:shoppy/screens/feeds/feed_products.dart';
import 'package:shoppy/screens/serach/searchby_header.dart';

class SearchPageModel with ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  String searchText = "";
  List<Product> searchList = [];

  void clearField() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => searchController.clear());
    searchText = "";
    notifyListeners();
  }

  void search(List<Product> list) {
    searchList = list;
    print(searchList.length);
    notifyListeners();
  }
}

class Search extends StatefulWidget {
  const Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsProvider>(context);
    return Scaffold(
      body: ChangeNotifierProvider<SearchPageModel>(
          create: (context) => SearchPageModel(),
          builder: (context, snapshot) {
            return Consumer<SearchPageModel>(builder: (context, model, child) {
              return CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                    floating: true,
                    pinned: true,
                    delegate: SearchByHeader(
                      stackPaddingTop: 175,
                      titlePaddingTop: 50,
                      title: RichText(
                        text: TextSpan(
                          text: "Search",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorsConsts.white,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      stackChild: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 1,
                              blurRadius: 3,
                            ),
                          ],
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          controller: model.searchController,
                          minLines: 1,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            hintText: "Search",
                            filled: true,
                            fillColor: Theme.of(context).canvasColor,
                            prefixIcon: Icon(
                              Icons.search,
                            ),
                            suffixIcon: model.searchText.trim().isEmpty
                                ? null
                                : Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        color: Colors.white,
                                        icon: Icon(Icons.clear),
                                        onPressed: model.clearField,
                                      ),
                                      IconButton(
                                        color: Colors.white,
                                        icon: Icon(Icons.search),
                                        onPressed: () {
                                          FocusScope.of(context).unfocus();

                                          model.search(products
                                              .findByQuery(model.searchText));
                                        },
                                      ),
                                    ],
                                  ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              model.searchText = value;
                              model.search(
                                  products.findByQuery(model.searchText));
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: model.searchController.text.isNotEmpty &&
                            model.searchList.isEmpty
                        ? Column(
                            children: [
                              SizedBox(
                                height: 50,
                              ),
                              Icon(Feather.search, size: 60),
                              SizedBox(
                                height: 50,
                              ),
                              Text(
                                "No Result",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w700),
                              )
                            ],
                          )
                        : GridView.count(
                            physics: NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            crossAxisSpacing: 2,
                            childAspectRatio: 240 / 420,
                            mainAxisSpacing: 8,
                            shrinkWrap: true,
                            children: List.generate(
                                model.searchController.text.isEmpty
                                    ? products.products.length
                                    : model.searchList.length, (index) {
                              final product =
                                  model.searchController.text.isEmpty
                                      ? products.products[index]
                                      : model.searchList[index];
                              return FeedProducts(product: product);
                            })),
                  )
                ],
              );
            });
          }),
    );
  }
}
