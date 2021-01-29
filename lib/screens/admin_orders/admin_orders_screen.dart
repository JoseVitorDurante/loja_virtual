import 'package:flutter/material.dart';
import 'package:flutter_loja_ultimo/common/custom_drawer/custom_drawer.dart';
import 'package:flutter_loja_ultimo/common/custom_icon_button.dart';
import 'package:flutter_loja_ultimo/common/empty_card.dart';
import 'package:flutter_loja_ultimo/models/admin_orders_manager.dart';
import 'package:flutter_loja_ultimo/models/order.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../common/order/order_tile.dart';

class AdminOrdersScreen extends StatefulWidget {
  @override
  _AdminOrdersScreenState createState() => _AdminOrdersScreenState();
}

class _AdminOrdersScreenState extends State<AdminOrdersScreen> {
  final PanelController panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Todos os pedidos"),
      ),
      body: Consumer<AdminOrdersManager>(builder: (_, orderManager, __) {
        final filteredOrders = orderManager.filteredOrders;

        return SlidingUpPanel(
          controller: panelController,
          body: Column(
            children: [
              if (orderManager.userFilter != null)
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 2),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        "Pedidos de ${orderManager.userFilter.name}",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w800),
                      )),
                      CustomIconButton(
                        iconData: Icons.close,
                        onTap: () => orderManager.setUserFilter(null),
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              if (filteredOrders.isEmpty)
                Expanded(
                  child: EmptyCard(
                    title: "Nenhuma venda realizada!",
                    iconData: Icons.border_clear,
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredOrders.length,
                    itemBuilder: (_, index) {
                      return OrderTile(
                        filteredOrders.toList()[index],
                        showControls: true,
                      );
                    },
                  ),
                ),
              SizedBox(
                height: 120,
              ),
            ],
          ),
          minHeight: 40,
          maxHeight: 240,
          panel: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () {
                  if (panelController.isPanelClosed) {
                    panelController.open();
                  } else {
                    panelController.close();
                  }
                },
                child: Container(
                  height: 40,
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: Text(
                    "Filtros",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 16),
                  ),
                ),
              ),
              Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: Status.values.map((s) {
                        return CheckboxListTile(
                            value: orderManager.statusFilter.contains(s),
                            dense: true,
                            activeColor: Theme.of(context).primaryColor,
                            title: Text(Order.getStatusText(s)),
                            onChanged: (v) {
                              orderManager.setStatusFilter(
                                status: s,
                                enabled: v,
                              );
                            });
                      }).toList()))
            ],
          ),
        );
      }),
    );
  }
}
