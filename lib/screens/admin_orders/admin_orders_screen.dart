import 'package:flutter/material.dart';
import 'package:flutter_loja_ultimo/common/custom_drawer/custom_drawer.dart';
import 'package:flutter_loja_ultimo/common/empty_card.dart';
import 'package:flutter_loja_ultimo/common/login_card.dart';
import 'package:flutter_loja_ultimo/models/admin_orders_manager.dart';
import 'package:provider/provider.dart';

import '../../common/order_tile.dart';

class AdminOrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Todos os pedidos"),
      ),
      body: Consumer<AdminOrdersManager>(
        builder: (_, adminOrdersManager, __) {
          if (adminOrdersManager.orders.isEmpty) {
            return EmptyCard(
              title: "Nenhuma venda realizada!",
              iconData: Icons.border_clear,
            );
          }
          return ListView.builder(
            itemCount: adminOrdersManager.orders.length,
            itemBuilder: (_, index) {
              return OrderTile(
                  adminOrdersManager.orders.reversed.toList()[index]);
            },
          );
        },
      ),
    );
  }
}
