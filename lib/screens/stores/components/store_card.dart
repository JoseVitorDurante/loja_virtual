import 'package:flutter/material.dart';
import 'package:flutter_loja_ultimo/common/custom_icon_button.dart';
import 'package:flutter_loja_ultimo/models/store.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreCard extends StatelessWidget {
  final Store store;

  const StoreCard(this.store);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    void showError(Error e){
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("${e} + função de abrir maps ou telefone"),
        backgroundColor: Colors.red,
      ));
    }

    Future<void> openPhone() async {
      if (await canLaunch("tel:${store.cleanPhone}"))
        launch("tel:${store.cleanPhone}");
      else
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Não e suportado em seu aparelho"),
          backgroundColor: Colors.red,
        ));
    }

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
                          onTap: () {
                            map.showMarker(
                              coords:
                                  Coords(store.address.lat, store.address.long),
                              title: store.name,
                              description: store.addressText,
                            );
                            Navigator.of(context).pop();
                          },
                          title: Text(map.mapName),
                          leading: Image(
                            image: map.icon,
                            width: 30,
                            height: 30,
                          ))
                  ],
                ),
              );
            });
      } catch (e) {
        showError(e);
      }
    }

    Color colorForStatus(StoreStatus status) {
      switch (status) {
        case StoreStatus.closed:
          return Colors.red;
        case StoreStatus.open:
          return Colors.green;
        case StoreStatus.closing:
          return Colors.purple;
        default:
          return Colors.black;
      }
    }

    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
                            BorderRadius.only(bottomLeft: Radius.circular(8))),
                    child: Text(
                      store.statusText,
                      style: TextStyle(
                          color: colorForStatus(store.status),
                          fontWeight: FontWeight.w800,
                          fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 150,
            padding: EdgeInsets.all(4),
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
                            fontSize: 17, fontWeight: FontWeight.w800),
                      ),
                      Text(
                        store.addressText,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Text(store.openingText,
                          style: TextStyle(
                            fontSize: 12,
                          )),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomIconButton(
                      iconData: Icons.map,
                      color: primaryColor,
                      onTap: openMap,
                    ),
                    CustomIconButton(
                      iconData: Icons.phone,
                      color: primaryColor,
                      onTap: openPhone,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
