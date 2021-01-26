import 'package:flutter/material.dart';
import 'package:flutter_loja_ultimo/models/order.dart';
import 'file:///C:/Users/josev/AndroidStudioProjects/flutter_loja_ultimo/lib/screens/cart/components/order_product_tile.dart';

class ConfirmationScreen extends StatelessWidget {
  final Order order;

  const ConfirmationScreen(this.order);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text("Pedido ${order.formattedId} confirmado"),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(16),
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.formattedId,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          color: primaryColor),
                    ),
                    Text(
                      "R\$ ${order.price.toStringAsFixed(2)}",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              Column(
                children: order.items.map((e) {
                  return OrderProductTile(e);
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
