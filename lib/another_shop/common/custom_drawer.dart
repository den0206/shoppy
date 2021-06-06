import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/another_shop/provider/page_manager.dart';
import 'package:shoppy/provider/userState.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 203, 236, 241),
                Colors.white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
          ),
          ListView(
            children: [
              CustomDrawerHeader(),
              DrawerTile(
                iconData: Icons.home,
                title: "Home",
                page: 0,
              ),
              DrawerTile(
                iconData: Icons.list,
                title: "Productions",
                page: 1,
              ),
              DrawerTile(
                iconData: Icons.playlist_add_check,
                title: "Menu",
                page: 2,
              ),
              DrawerTile(
                iconData: Icons.location_on,
                title: "Location",
                page: 3,
              ),
              AdminSpace(),
            ],
          ),
        ],
      ),
    );
  }
}

class AdminSpace extends StatelessWidget {
  const AdminSpace({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return adminEnable
        ? Column(
            children: [
              Divider(),
              DrawerTile(
                iconData: Icons.settings,
                title: "Setting",
                page: 4,
              ),
              DrawerTile(
                iconData: Icons.settings,
                title: "Setting2",
                page: 5,
              ),
            ],
          )
        : Container();
  }
}

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(32, 24, 16, 8),
      height: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "welcome name",
            style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
          ),
          Text(
            "userName",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: () {
              context.read<PageManager>().setPage(0);
              context.read<UserState>().logout();
            },
            child: Text(
              "Logout",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    Key key,
    this.iconData,
    this.title,
    this.page,
  }) : super(key: key);

  final IconData iconData;
  final String title;
  final int page;

  @override
  Widget build(BuildContext context) {
    final int currentPage = context.watch<PageManager>().page;
    final Color primaryColor = Theme.of(context).primaryColor;

    return InkWell(
      onTap: () {
        context.read<PageManager>().setPage(page);
      },
      child: SizedBox(
        height: 60,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Icon(
                iconData,
                size: 32,
                color: currentPage == page ? primaryColor : Colors.grey[700],
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: currentPage == page ? primaryColor : Colors.grey[700],
              ),
            )
          ],
        ),
      ),
    );
  }
}
