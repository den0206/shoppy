import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/Extension/CostomWidgets.dart';
import 'package:shoppy/another_shop/common/custom_drawer.dart';
import 'package:shoppy/another_shop/model/section.dart';
import 'package:shoppy/another_shop/provider/home_manager.dart';
import 'package:shoppy/another_shop/screens/cart_screen.dart';
import 'package:shoppy/another_shop/screens/components/item_title.dart';
import 'package:shoppy/provider/userState.dart';

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
                  ),
                  Consumer<HomeManager>(
                    builder: (context, model, child) {
                      if (adminEnable) {
                        if (model.editing) {
                          return PopupMenuButton(
                            onSelected: (e) {
                              if (e == "Save") {
                                model.saveEditing();
                              } else {
                                model.discardEditing();
                              }
                            },
                            itemBuilder: (context) {
                              return ["Save", "Discard"].map((e) {
                                return PopupMenuItem(
                                  value: e,
                                  child: Text(e),
                                );
                              }).toList();
                            },
                          );
                        } else {
                          return IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: model.enterEditing,
                          );
                        }
                      } else
                        return Container();
                    },
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

                  if (model.editing)
                    children.add(
                      AddSectionWidget(
                        homeManager: model,
                      ),
                    );

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
    final homeManager = context.watch<HomeManager>();

    return ChangeNotifierProvider.value(
      value: section,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(),
            SizedBox(
              height: 150,
              child: Consumer<Section>(builder: (_, model, __) {
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => SizedBox(width: 4),
                  itemCount: homeManager.editing
                      ? section.items.length + 1
                      : section.items.length,
                  itemBuilder: (context, index) {
                    if (index < section.items.length) {
                      return ItemTile(item: section.items[index]);
                    } else {
                      return AddTileWidget();
                    }
                  },
                );
              }),
            )
          ],
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
    final homeManager = context.watch<HomeManager>();

    return ChangeNotifierProvider.value(
      value: section,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(),
            Consumer<Section>(builder: (_, model, __) {
              return StaggeredGridView.countBuilder(
                padding: EdgeInsets.zero,
                crossAxisCount: 4,
                shrinkWrap: true,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                itemCount: homeManager.editing
                    ? section.items.length + 1
                    : section.items.length,
                itemBuilder: (context, index) {
                  if (index < section.items.length) {
                    return ItemTile(item: section.items[index]);
                  } else {
                    return AddTileWidget();
                  }
                },
                staggeredTileBuilder: (index) =>
                    StaggeredTile.count(2, index.isEven ? 2 : 1),
              );
            })
          ],
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    Key key,
  }) : super(key: key);

  // final Section section;

  @override
  Widget build(BuildContext context) {
    final model = context.watch<HomeManager>();
    final section = context.watch<Section>();

    if (model.editing) {
      return Row(
        children: [
          Expanded(
            child: TextFormField(
              initialValue: section.name,
              decoration: InputDecoration(
                  hintText: "Title", isDense: true, border: InputBorder.none),
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 18),
              onChanged: (text) => section.name = text,
            ),
          ),
          CircleiconButton(
            iconData: Icons.remove,
            color: Colors.white,
            onTap: () {
              model.removeSection(section);
            },
          ),
        ],
      );
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text(
          section.name ?? "Name",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
      );
    }
  }
}

class AddSectionWidget extends StatelessWidget {
  const AddSectionWidget({
    Key key,
    this.homeManager,
  }) : super(key: key);

  final HomeManager homeManager;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            child: Text(
              "Section List",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              homeManager.addSection(Section(type: "List"));
            },
          ),
        ),
        Expanded(
          child: TextButton(
            child: Text(
              "Section Staggred",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              homeManager.addSection(Section(type: "Staggered"));
            },
          ),
        ),
      ],
    );
  }
}
