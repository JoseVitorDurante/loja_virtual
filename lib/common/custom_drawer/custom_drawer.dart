import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_drawer_header.dart';
import 'drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color.fromRGBO(255, 203, 236, 241), Colors.white],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
          ),
          ListView(
            children: [
              CustomDrawerHeader(),
              Divider(),
              DrawerTile(
                iconData: Icons.home,
                title: "Inicio",
                page: 0,
              ),
              DrawerTile(
                iconData: Icons.list,
                title: "Produtos",
                page: 1,
              ),
              DrawerTile(
                  iconData: Icons.playlist_add_check,
                  title: "Meus pedidos",
                  page: 2),
              DrawerTile(
                iconData: Icons.location_on,
                title: "Lojas",
                page: 3,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
