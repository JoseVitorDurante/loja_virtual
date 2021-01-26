import 'package:flutter/material.dart';
import 'package:flutter_loja_ultimo/common/custom_drawer/custom_drawer.dart';
import 'package:flutter_loja_ultimo/common/empty_card.dart';
import 'package:flutter_loja_ultimo/common/login_card.dart';
import 'package:flutter_loja_ultimo/models/orders_manager.dart';
import 'package:provider/provider.dart';

import '../../common/order_tile.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        centerTitle: true,
          title: Text("Meus pedidos"),
      ),
      body: Consumer<OrdersManager>(
        builder: (_, ordersManager, __){
          if(ordersManager.user ==  null){
            return LoginCard();
          }
          if(ordersManager.orders.isEmpty){
            return EmptyCard(title: "Nenhuma compra encontrada", iconData: Icons.border_clear,);
          }
          return ListView.builder(itemCount: ordersManager.orders.length,itemBuilder: (_, index){
            return OrderTile(ordersManager.orders.reversed.toList()[index]);
          },);
        },
      ),
    );
  }
}
