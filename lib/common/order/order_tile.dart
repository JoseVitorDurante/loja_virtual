import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loja_ultimo/models/order.dart';
import 'cancel_order_dialog.dart';
import 'export_address_dialog.dart';
import 'order_product_tile.dart';

class OrderTile extends StatelessWidget {
  final Order order;
  final bool showControls;

  const OrderTile(this.order, {this.showControls = false});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.formattedId,
                  style: TextStyle(
                      fontWeight: FontWeight.w800, color: primaryColor),
                ),
                Text(
                  "R\$ ${order.price.toStringAsFixed(2)}",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 14),
                ),
              ],
            ),
            Text(
              order.statusText,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: order.status == Status.canceled
                      ? Colors.red
                      : order.status == Status.delivered
                          ? Colors.green
                          : primaryColor,
                  fontSize: 14),
            )
          ],
        ),
        children: [
          Column(
            children: order.items.map((e) {
              return OrderProductTile(e);
            }).toList(),
          ),
          if (showControls && order.status != Status.canceled)
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  FlatButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => CancelOrderDialog(order));
                    },
                    child: Text("Cancelar"),
                    textColor: Colors.red,
                  ),
                  FlatButton(
                    onPressed: order.back,
                    child: Text("Recuar"),
                  ),
                  FlatButton(
                    onPressed: order.advance,
                    child: Text("Avançar"),
                  ),
                  FlatButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) =>
                              ExportAddressDialog(order.address));
                    },
                    child: Text("Endereço"),
                    textColor: Colors.green,
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
