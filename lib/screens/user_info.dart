import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/Provider/dark_theme_provider.dart';
import 'package:shoppy/consts/colors.dart';

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
                                        image: NetworkImage(
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
                          image: NetworkImage(
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
                    userTitle("User Info"),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    userListTile('Email', 'Email sub', 0, context),
                    userListTile('Phone number', '4555', 1, context),
                    userListTile('Shipping address', '', 2, context),
                    userListTile('joined date', 'date', 3, context),
                    userTitle("User Settings"),
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
                    userListTile("Logout", "", 4, context),
                  ],
                ),
              )
            ],
          ),
          _buildFab(),
        ],
      ),
    );
  }

  Padding userTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 14),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
      ),
    );
  }

  Material userListTile(
      String title, String subtitle, int index, BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Theme.of(context).splashColor,
        child: ListTile(
          title: Text(title),
          subtitle: Text(subtitle),
          leading: Icon(_userTileIcons[index]),
          onTap: () {
            print("email");
          },
        ),
      ),
    );
  }

  Widget _buildFab() {
    //starting fab position
    final double defaultTopMargin = 200.0 - 4.0;
    //pixels from top where scaling should start
    final double scaleStart = 160.0;
    //pixels from top where scaling should end
    final double scaleEnd = scaleStart / 2;

    double top = defaultTopMargin;
    double scale = 1.0;
    if (_scontroller.hasClients) {
      double offset = _scontroller.offset;
      top -= offset;
      if (offset < defaultTopMargin - scaleStart) {
        //offset small => don't scale down
        scale = 1.0;
      } else if (offset < defaultTopMargin - scaleEnd) {
        //offset between scaleStart and scaleEnd => scale down
        scale = (defaultTopMargin - scaleEnd - offset) / scaleEnd;
      } else {
        //offset passed scaleEnd => hide fab
        scale = 0.0;
      }
    }

    return Positioned(
      top: top,
      right: 16.0,
      child: Transform(
        transform: Matrix4.identity()..scale(scale),
        alignment: Alignment.center,
        child: FloatingActionButton(
          backgroundColor: Colors.purple,
          heroTag: "btn1",
          onPressed: () {
            print("Camera");
          },
          child: Icon(Icons.camera_alt_outlined),
        ),
      ),
    );
  }
}

const List<IconData> _userTileIcons = [
  Icons.email,
  Icons.phone,
  Icons.local_shipping,
  Icons.watch_later,
  Icons.exit_to_app_rounded
];
