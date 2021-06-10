import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/Provider/dark_theme_provider.dart';
import 'package:shoppy/another_shop/provider/admin_user_manager.dart';
import 'package:shoppy/another_shop/provider/cart_manager.dart';
import 'package:shoppy/another_shop/provider/home_manager.dart';
import 'package:shoppy/another_shop/provider/product_manager.dart';
import 'package:shoppy/another_shop/screens/base_screen.dart';
import 'package:shoppy/another_shop/screens/cart_screen.dart';
import 'package:shoppy/another_shop/screens/edit_product_screen.dart';
import 'package:shoppy/another_shop/screens/product_screen.dart';
import 'package:shoppy/another_shop/screens/select_product.dart';
import 'package:shoppy/model/product.dart';
import 'package:shoppy/provider/cart_provider.dart';
import 'package:shoppy/provider/products_provider.dart';
import 'package:shoppy/provider/userState.dart';
import 'package:shoppy/provider/wishlist_provider.dart';
import 'package:shoppy/screens/auth/login.dart';
import 'package:shoppy/screens/auth/signup.dart';
import 'package:shoppy/screens/bottom_bar.dart';
import 'package:shoppy/screens/brandRails/brand_rails.dart';
import 'package:shoppy/screens/cart/cart.dart';
import 'package:shoppy/screens/feeds/category_feeds.dart';
import 'package:shoppy/screens/feeds/feeds.dart';
import 'package:shoppy/screens/landing_page.dart';
import 'package:shoppy/screens/product_details.dart';
import 'package:shoppy/screens/swipe_page.dart';
import 'package:shoppy/screens/wishlist/wishlist.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // runApp(MyApp());
  runApp(Shop2());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserState>(
          create: (context) => UserState(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider<BottomBarModel>(
          create: (context) => BottomBarModel(),
        ),
        ChangeNotifierProvider<ProductsProvider>(
          create: (context) => ProductsProvider(),
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider<WishlistProvider>(
          create: (context) => WishlistProvider(),
        )
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeData, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: themeData.buildTheme(),
            routes: {
              LoginPgge.routeName: (context) => LoginPgge(),
              SignupPage.routeName: (context) => SignupPage(),
              SwipePage.routeName: (context) => SwipePage(),
              BottomBarScreen.routeName: (context) => BottomBarScreen(),
              CartPage.routeName: (context) => CartPage(),
              Feeds.routeName: (context) => Feeds(),
              WishListScreen.routeName: (context) => WishListScreen(),
              BrandNavigationRail.routeName: (context) => BrandNavigationRail(),
              DetailProductPage.routeName: (context) => DetailProductPage(),
              CategoryFeeds.routeName: (context) => CategoryFeeds(),
            },
            home: UserCheckPage(),
          );
        },
      ),
    );
  }
}

class UserCheckPage extends StatelessWidget {
  const UserCheckPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<UserState>(context);
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      // ignore: missing_return
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            if (currentUser != null) {
              return SwipePage();
            } else {
              userState.setUser();
              return Center(
                child: CircularProgressIndicator(backgroundColor: Colors.white),
              );
            }
          } else {
            return LandingPage();
          }
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Error occured"),
          );
        }
      },
    );
  }
}

class Shop2 extends StatelessWidget {
  const Shop2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserState>(
          create: (context) => UserState()..setUser(),
        ),
        ChangeNotifierProvider<ProductManager>(
          create: (context) => ProductManager(),
          lazy: false,
        ),
        ChangeNotifierProvider<HomeManager>(
          create: (context) => HomeManager(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<UserState, CartManager>(
          create: (context) => CartManager(),
          update: (_, userManager, cartManager) =>
              cartManager..updateUser(userManager),
        ),
        ChangeNotifierProxyProvider<UserState, AdminUserManager>(
          create: (context) => AdminUserManager(),
          lazy: false,
          update: (context, userState, adminUserManager) =>
              adminUserManager..updateUsers(userState),
        )
      ],
      child: MaterialApp(
        title: "Shop2",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 4, 125, 141),
          scaffoldBackgroundColor: const Color.fromARGB(255, 4, 125, 141),
          appBarTheme: const AppBarTheme(elevation: 0),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          ProductScreen.routeName: (context) => ProductScreen(),
          CartScreen.routeName: (context) => CartScreen(),
        },
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case EditProductScreen.routeName:
              return MaterialPageRoute(
                builder: (context) => EditProductScreen(
                  product: settings.name as Product,
                ),
              );
            case SelectProductScreen.routeName:
              return MaterialPageRoute(
                builder: (_) => SelectProductScreen(),
              );
            default:
              return MaterialPageRoute(
                  builder: (_) => BaseScreen(), settings: settings);
          }
        },
        // home: EditProductScreen(
        //   product: sampleProducts[0],
        // ),
        home: BaseScreen(),
      ),
    );
  }
}
