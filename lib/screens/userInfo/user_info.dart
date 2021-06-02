import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/Provider/dark_theme_provider.dart';
import 'package:shoppy/consts/colors.dart';
import 'package:shoppy/provider/userState.dart';
import 'package:shoppy/screens/userInfo/userInfo_widget.dart';

const List<IconData> _userTileIcons = [
  Icons.email,
  Icons.phone,
  Icons.local_shipping,
  Icons.watch_later,
  Icons.exit_to_app_rounded
];

class UserInfo extends StatefulWidget {
  const UserInfo({Key key}) : super(key: key);

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  ScrollController _scontroller;
  var top = 0.0;

  @override
  void initState() {
    super.initState();
    _scontroller = ScrollController();
    _scontroller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scontroller,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                elevation: 4,
                expandedHeight: MediaQuery.of(context).size.height / 4,
                pinned: true,
                flexibleSpace: LayoutBuilder(
                  builder: (context, constraints) {
                    top = constraints.biggest.height;
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              ColorsConsts.starterColor,
                              ColorsConsts.endColor
                            ],
                            begin: const FractionalOffset(0.0, 0.0),
                            end: const FractionalOffset(1.0, 0.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                      child: FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        centerTitle: true,
                        title: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AnimatedOpacity(
                              duration: Duration(milliseconds: 300),
                              opacity: top <= 110.0 ? 1.0 : 0,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Container(
                                    height: kToolbarHeight / 1.8,
                                    width: kToolbarHeight / 1.8,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white,
                                          blurRadius: 1.0,
                                        ),
                                      ],
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: currentUser != null
                                            ? CachedNetworkImageProvider(
                                                currentUser.imageUrl)
                                            : NetworkImage(
                                                'https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg'),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    "Guest",
                                    style: TextStyle(
                                        fontSize: 29, color: Colors.white),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        background: Image(
                          image: currentUser != null
                              ? CachedNetworkImageProvider(currentUser.imageUrl)
                              : NetworkImage(
                                  'https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UserTitle(title: "User info"),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    UserListTile(
                      title: "Email",
                      subtitle: currentUser != null ? currentUser.email : "@",
                      icon: Icon(_userTileIcons[0]),
                      ontap: () {
                        print("Email");
                      },
                    ),
                    UserListTile(
                        title: "Phone number",
                        subtitle: "Phone number",
                        icon: Icon(_userTileIcons[1])),
                    UserListTile(
                        title: "Shipping address",
                        subtitle: "address",
                        icon: Icon(_userTileIcons[2])),
                    UserListTile(
                        title: "joined date",
                        subtitle: "date",
                        icon: Icon(_userTileIcons[3])),
                    UserTitle(title: "User Settings"),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    ListTileSwitch(
                      value: Provider.of<ThemeProvider>(context).darkMode,
                      leading: Icon(Ionicons.md_moon),
                      onChanged: (value) {
                        themeChange.toggleButtons();
                      },
                      visualDensity: VisualDensity.comfortable,
                      switchActiveColor: Colors.indigo,
                      switchScale: 0.8,
                      switchType: SwitchType.cupertino,
                      title: Text(
                        'Dark Theme',
                      ),
                    ),
                    UserListTile(
                      title: "Logout",
                      subtitle: "",
                      icon: Icon(_userTileIcons[4]),
                      ontap: () {
                        final userState =
                            Provider.of<UserState>(context, listen: false);

                        userState.logout();
                      },
                    )
                  ],
                ),
              )
            ],
          ),
          CameraButton(scrollController: _scontroller)
        ],
      ),
    );
  }
}
