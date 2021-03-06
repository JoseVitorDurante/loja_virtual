import 'package:flutter/material.dart';
import 'package:flutter_loja_ultimo/models/order.dart';

class CancelOrderDialog extends StatefulWidget {
  final Order order;

  const CancelOrderDialog(this.order);

  @override
  _CancelOrderDialogState createState() => _CancelOrderDialogState();
}

class _CancelOrderDialogState extends State<CancelOrderDialog> {
  bool loading = false;
  String error;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: AlertDialog(
        title: Text("Cancelar ${widget.order.formattedId}?"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(loading
                ? "Cancelando ..."
                : "Esta ação não podera ser desfeita!"),
            if (error != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  "$error",
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
        actions: [
          FlatButton(
            onPressed: !loading
                ? () {
                    Navigator.of(context).pop();
                  }
                : null,
            textColor: Theme.of(context).primaryColor,
            child: Text("Voltar"),
          ),
          SizedBox(
            width: 20,
          ),
          FlatButton(
            onPressed: !loading
                ? () async {
                    setState(() {
                      loading = true;
                    });
                    try {
                      await widget.order.cancel();
                      Navigator.of(context).pop();
                    } catch (e) {
                      setState(() {
                        loading = false;
                      });
                      error = e.toString();
                    }
                  }
                : null,
            textColor: Colors.red,
            child: Text("Cancelar Pedido"),
          ),
        ],
      ),
    );
  }
}
