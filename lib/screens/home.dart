import 'package:backdrop/app_bar.dart';
import 'package:backdrop/button.dart';
import 'package:backdrop/scaffold.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/Extension/global_function.dart';
import 'package:shoppy/consts/colors.dart';
import 'package:shoppy/consts/my_icons.dart';
import 'package:shoppy/model/category.dart';
import 'package:shoppy/model/popular_brand.dart';
import 'package:shoppy/model/product.dart';
import 'package:shoppy/provider/products_provider.dart';
import 'package:shoppy/provider/userState.dart';
import 'package:shoppy/screens/brandRails/brand_rails.dart';
import 'package:shoppy/screens/cart/cart.dart';
import 'package:shoppy/screens/category/categoryScreen.dart';
import 'package:shoppy/screens/feeds/feeds.dart';
import 'package:shoppy/screens/wishlist/wishlist.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final popularProducts = productsProvider.popularProducts;

    return Scaffold(
      body: BackdropScaffold(
        frontLayerBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        headerHeight: MediaQuery.of(context).size.height * 0.25,
        appBar: BackdropAppBar(
          title: Text("Home"),
          leading: BackdropToggleButton(
            icon: AnimatedIcons.home_menu,
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [ColorsConsts.starterColor, ColorsConsts.endColor],
              ),
            ),
          ),
          actions: [
            // IconButton(
            //   icon: Icon(Icons.person),
            //   onPressed: () {},
            // ),
            IconButton(
              iconSize: 15,
              padding: EdgeInsets.all(10),
              icon: CircleAvatar(
                radius: 13,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 13,
                  backgroundImage: currentUser != null
                      ? CachedNetworkImageProvider(currentUser.imageUrl)
                      : NetworkImage(
                          'https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg',
                        ),
                ),
              ),
              onPressed: () {},
            )
          ],
        ),
        backLayer: BackLayerMenu(),
        frontLayer: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 4,
                width: double.infinity,
                child: Carousel(
                  boxFit: BoxFit.fill,
                  autoplay: true,
                  animationCurve: Curves.fastOutSlowIn,
                  animationDuration: Duration(milliseconds: 1000),
                  dotSize: 5,
                  dotIncreasedColor: Colors.purple,
                  dotBgColor: Colors.black..withOpacity(0.2),
                  dotPosition: DotPosition.bottomCenter,
                  showIndicator: true,
                  indicatorBgPadding: 5.0,
                  images: [
                    ExactAssetImage(_carouselImages[0]),
                    ExactAssetImage(_carouselImages[1]),
                    ExactAssetImage(_carouselImages[2]),
                    ExactAssetImage(_carouselImages[3]),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  "Categories",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 180,
                child: ListView.builder(
                  itemCount: categories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final KCategory category = categories[index];

                    return CategoryScreen(
                      category: category,
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text(
                      "Popular Brands",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                      ),
                    ),
                    Spacer(),
                    TextButton(
                      child: Text(
                        "View all...",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                          color: Colors.red,
                        ),
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
              Container(
                height: 210,
                width: MediaQuery.of(context).size.width * 0.95,
                child: Swiper(
                  itemCount: brands.length - 1,
                  autoplay: true,
                  viewportFraction: 0.8,
                  scale: 0.9,
                  onTap: (index) {
                    Navigator.of(context).pushNamed(
                        BrandNavigationRail.routeName,
                        arguments: index);
                  },
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        color: Colors.blueGrey,
                        child: Image.asset(
                          brands[index].imagePath,
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text(
                      "Popula Products",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                      ),
                    ),
                    Spacer(),
                    TextButton(
                      child: Text(
                        "View all...",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                          color: Colors.red,
                        ),
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 285,
                margin: EdgeInsets.symmetric(horizontal: 3),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: popularProducts.length,
                  itemBuilder: (context, index) {
                    return PopularProducts(
                      product: popularProducts[index],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

final List _carouselImages = [
  'assets/images/carousel1.png',
  'assets/images/carousel2.jpeg',
  'assets/images/carousel3.jpg',
  'assets/images/carousel4.png',
];

class BackLayerMenu extends StatelessWidget {
  const BackLayerMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorsConsts.starterColor,
                  ColorsConsts.endColor,
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
          ),
          Positioned(
            top: -100,
            left: 140,
            child: Transform.rotate(
              angle: -0.5,
              child: Container(
                width: 150,
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 100,
            child: Transform.rotate(
              angle: -0.8,
              child: Container(
                width: 150,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
            ),
          ),
          Positioned(
            top: -50,
            left: 60,
            child: Transform.rotate(
              angle: -0.8,
              child: Container(
                width: 150,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 0,
            child: Transform.rotate(
              angle: -0.8,
              child: Container(
                width: 150,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg',
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _NavigatoMenu(
                    title: "Feeds",
                    index: 0,
                    onTap: () {
                      navigateTo(context, Feeds.routeName);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _NavigatoMenu(
                    title: "Cart",
                    index: 1,
                    onTap: () {
                      navigateTo(context, CartPage.routeName);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _NavigatoMenu(
                    title: "WishList",
                    index: 2,
                    onTap: () {
                      navigateTo(context, WishListScreen.routeName);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _NavigatoMenu(
                    title: "Upload New Product",
                    index: 3,
                    onTap: () {
                      print("Upload");
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List _contentIcons = [
  MyAppIcons.rss,
  MyAppIcons.bag,
  MyAppIcons.wishlist,
  MyAppIcons.upload
];

class _NavigatoMenu extends StatelessWidget {
  const _NavigatoMenu({
    Key key,
    this.title,
    this.index,
    this.onTap,
  }) : super(key: key);

  final String title;
  final int index;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Icon(_contentIcons[index]),
        ],
      ),
      onTap: onTap,
    );
  }
}

class PopularProducts extends StatelessWidget {
  const PopularProducts({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Container(
        width: 250,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 170,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(product.imageUrl),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 12,
                      top: 10,
                      child: Icon(
                        Entypo.star,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    Positioned(
                      right: 10,
                      top: 7,
                      child: Icon(
                        Entypo.star_outlined,
                        color: Colors.white,
                      ),
                    ),
                    Positioned(
                      right: 12,
                      bottom: 32,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        color: Theme.of(context).backgroundColor,
                        child: Text(
                          '\$ ${product.price}',
                          style: TextStyle(
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "${product.category}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[800],
                            ),
                          ),
                          Spacer(),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(30),
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Icon(
                                  MaterialCommunityIcons.cart_plus,
                                  size: 25,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
