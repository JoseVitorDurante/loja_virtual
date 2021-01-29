import 'package:flutter/material.dart';
import 'package:flutter_loja_ultimo/models/order.dart';

class CancelOrderDialog extends StatelessWidget {
  final Order order;

  const CancelOrderDialog(this.order);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Cancelar ${order.formattedId}?"),
      content: Text("Esta ação não podera ser desfeita!"),
      actions: [
        FlatButton(onPressed: () {
          order.cancel();
          Navigator.of(context).pop();
        }, textColor: Colors.red, child: Text("Cancelar Pedido"),)
      ],
    );
  }
}
