import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/consts/my_icons.dart';
import 'package:shoppy/screens/cart/cart.dart';
import 'package:shoppy/screens/feeds/feeds.dart';
import 'package:shoppy/screens/home.dart';
import 'package:shoppy/screens/serach/search.dart';
import 'package:shoppy/screens/userInfo/user_info.dart';

class BottomBarModel extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}

class BottomBarScreen extends StatelessWidget {
  const BottomBarScreen({Key key}) : super(key: key);

  static const routeName = '/BottombarScreen';

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      Home(),
      Feeds(),
      Search(),
      CartPage(),
      UserInfo(),
    ];

    return Consumer<BottomBarModel>(builder: (context, model, child) {
      return Scaffold(
        body: _pages[model.currentIndex],
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 0.01,
          clipBehavior: Clip.antiAlias,
          child: Container(
            // height: kBottomNavigationBarHeight * 0.98,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.grey, width: 0.5),
                ),
              ),
              child: BottomNavigationBar(
                onTap: model.setIndex,
                backgroundColor: Theme.of(context).primaryColor,
                unselectedItemColor:
                    Theme.of(context).textSelectionTheme.selectionColor,
                selectedItemColor: Colors.purple,
                currentIndex: model.currentIndex,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(MyAppIcons.home),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(MyAppIcons.rss),
                    label: "Feeds",
                  ),
                  BottomNavigationBarItem(
                    activeIcon: null,
                    icon: Icon(null),
                    label: "Search",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(MyAppIcons.cart),
                    label: "Cart",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(MyAppIcons.user),
                    label: "User",
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: Padding(
          padding: EdgeInsets.all(8),
          child: FloatingActionButton(
            backgroundColor: Colors.purple,
            hoverElevation: 10,
            splashColor: Colors.grey,
            tooltip: "Search",
            elevation: 4,
            child: (Icon(MyAppIcons.search)),
            onPressed: () {
              model.setIndex(2);
            },
          ),
        ),
      );
    });
  }
}

// class BottomBarScreen extends StatefulWidget {
//   BottomBarScreen({Key key}) : super(key: key);

//   @override
//   _BottomBarScreenState createState() => _BottomBarScreenState();
// }

// class _BottomBarScreenState extends State<BottomBarScreen> {
//   List<Map<String, Object>> _pages;
//   int _selectedIndex = 0;

//   @override
//   void initState() {
//     _pages = [
//       {
//         'page': Home(),
//       },
//       {
//         'page': Feeds(),
//       },
//       {
//         'page': Search(),
//       },
//       {
//         'page': CartScreen(),
//       },
//       {
//         'page': UserInfo(),
//       },
//     ];

//     super.initState();
//   }

//   void selectedPage(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_selectedIndex]["page"],
//       bottomNavigationBar: BottomAppBar(
//         shape: CircularNotchedRectangle(),
//         notchMargin: 0.01,
//         clipBehavior: Clip.antiAlias,
//         child: Container(
//           // height: kBottomNavigationBarHeight * 0.98,
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               border: Border(
//                 top: BorderSide(color: Colors.grey, width: 0.5),
//               ),
//             ),
//             child: BottomNavigationBar(
//               onTap: selectedPage,
//               backgroundColor: Theme.of(context).primaryColor,
//               unselectedItemColor:
//                   Theme.of(context).textSelectionTheme.selectionColor,
//               selectedItemColor: Colors.purple,
//               currentIndex: _selectedIndex,
//               items: [
//                 BottomNavigationBarItem(
//                   icon: Icon(MyAppIcons.home),
//                   label: "Home",
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(MyAppIcons.rss),
//                   label: "Feeds",
//                 ),
//                 BottomNavigationBarItem(
//                   activeIcon: null,
//                   icon: Icon(null),
//                   label: "Search",
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(MyAppIcons.cart),
//                   label: "Cart",
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(MyAppIcons.user),
//                   label: "User",
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       floatingActionButtonLocation:
//           FloatingActionButtonLocation.miniCenterDocked,
//       floatingActionButton: Padding(
//         padding: EdgeInsets.all(8),
//         child: FloatingActionButton(
//           backgroundColor: Colors.purple,
//           hoverElevation: 10,
//           splashColor: Colors.grey,
//           tooltip: "Search",
//           elevation: 4,
//           child: (Icon(MyAppIcons.search)),
//           onPressed: () {
//             setState(() {
//               _selectedIndex = 2;
//             });
//           },
//         ),
//       ),
//     );
//   }
// }
