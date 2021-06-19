import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/Extension/CostomWidgets.dart';
import 'package:shoppy/Extension/global_function.dart';
import 'package:shoppy/another_shop/model/store.dart';
import 'package:shoppy/another_shop/provider/store_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stores'),
      ),
      body: Consumer<StoreManager>(
        builder: (_, model, __) {
          if (model.stores.isEmpty) {
            return LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
              backgroundColor: Colors.transparent,
            );
          }

          return ListView.builder(
            itemCount: model.stores.length,
            itemBuilder: (_, index) {
              return StoreCard(
                store: model.stores[index],
              );
            },
          );
        },
      ),
    );
  }
}

class StoreCard extends StatelessWidget {
  const StoreCard({Key key, this.store}) : super(key: key);

  final Store store;

  @override
  Widget build(BuildContext context) {
    Future<void> openMap() async {
      try {
        final availableMaps = await MapLauncher.installedMaps;

        showModalBottomSheet(
          context: context,
          builder: (_) {
            return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final map in availableMaps)
                    ListTile(
                      title: Text(map.mapName),
                      leading: Icon(
                        Icons.map,
                        size: 30,
                      ),
                      onTap: () {
                        map.showMarker(
                          coords: Coords(0.0, 0.0),
                          title: store.name,
                          description: store.addresText,
                        );
                        Navigator.of(context).pop();
                      },
                    )
                ],
              ),
            );
          },
        );
      } catch (e) {
        showErrorAlert(context, e);
      }
    }

    Future<void> openPhone() async {
      if (await canLaunch('tel:${store.cleanPhone}')) {
        launch('tel:${store.cleanPhone}');
      } else {
        final error = Exception("Can't phone");
        showErrorAlert(context, error);
      }
    }

    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            height: 160,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  store.image,
                  fit: BoxFit.cover,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(8)),
                    ),
                    child: Text(
                      store.status.statusText,
                      style: TextStyle(
                        color: store.status.colorForStatus,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 140,
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        store.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        store.addresText,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Text(
                        store.openingText,
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleiconButton(
                      iconData: Icons.map,
                      color: Theme.of(context).primaryColor,
                      onTap: openMap,
                    ),
                    CircleiconButton(
                      iconData: Icons.phone,
                      color: Theme.of(context).primaryColor,
                      onTap: openPhone,
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
