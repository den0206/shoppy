import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/Extension/CostomWidgets.dart';
import 'package:shoppy/another_shop/common/custom_drawer.dart';
import 'package:shoppy/another_shop/model/section.dart';
import 'package:shoppy/another_shop/provider/home_manager.dart';
import 'package:shoppy/another_shop/screens/cart_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 211, 118, 130),
                  Color.fromARGB(255, 253, 181, 168),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                snap: true,
                floating: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text("Home"),
                  centerTitle: true,
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.shopping_cart),
                    color: Colors.white,
                    onPressed: () =>
                        Navigator.of(context).pushNamed(CartScreen.routeName),
                  )
                ],
              ),
              Consumer<HomeManager>(
                builder: (_, model, __) {
                  final List<Widget> children = model.sections.map((section) {
                    switch (section.type) {
                      case "List":
                        return SectionList(section: section);
                      case "Staggered":
                        return StaggeredSectionList(section: section);
                      default:
                        return Container();
                    }
                  }).toList();
                  // ..add(
                  //   CustomButton(
                  //     title: "Upload",
                  //     isLoading: model.isLoading,
                  //     onPressed: () async {
                  //       await model.updateSampe();
                  //     },
                  //   ),
                  // );

                  return SliverList(
                      delegate: SliverChildListDelegate(children));
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}

class SectionList extends StatelessWidget {
  const SectionList({
    Key key,
    @required this.section,
  }) : super(key: key);

  final Section section;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(section: section),
          SizedBox(
            height: 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => SizedBox(width: 4),
              itemCount: section.items.length,
              itemBuilder: (context, index) {
                return AspectRatio(
                  aspectRatio: 1,
                  child: CachedNetworkImage(
                    imageUrl: section.items[index].image,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    Key key,
    @required this.section,
  }) : super(key: key);

  final Section section;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Text(
        section.name,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 18,
        ),
      ),
    );
  }
}

class StaggeredSectionList extends StatelessWidget {
  const StaggeredSectionList({
    Key key,
    @required this.section,
  }) : super(key: key);

  final Section section;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(section: section),
          StaggeredGridView.countBuilder(
            padding: EdgeInsets.zero,
            crossAxisCount: 4,
            shrinkWrap: true,
            itemCount: section.items.length,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                imageUrl: section.items[index].image,
                fit: BoxFit.cover,
              );
            },
            staggeredTileBuilder: (index) =>
                StaggeredTile.count(2, index.isEven ? 2 : 1),
          )
        ],
      ),
    );
  }
}
