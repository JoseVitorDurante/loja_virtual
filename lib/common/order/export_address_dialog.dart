import 'package:flutter/material.dart';
import 'package:flutter_loja_ultimo/models/address.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:screenshot/screenshot.dart';

class ExportAddressDialog extends StatelessWidget {
  final Address address;

  ExportAddressDialog(this.address);

  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Screenshot(
          controller: screenshotController, child: Text("Endereço de entrega")),
      content: Container(
        padding: EdgeInsets.all(8),
        color: Colors.white,
        child: Text(
          " ${address.street}, ${address.number}, ${address.complement} \n ${address.district} \n ${address.city}/${address.state}\n ${address.zipCode}",
          style: TextStyle(color: Colors.black),
        ),
      ),
      actions: [
        FlatButton(
          onPressed: () async {
            Navigator.of(context).pop();
            final file = await screenshotController.capture();
            await GallerySaver.saveImage(file.path);
          },
          child: Text("Exportar"),
          textColor: Theme.of(context).primaryColor,
        )
      ],
      contentPadding: EdgeInsets.fromLTRB(16, 16, 16, 0),
    );
  }
}
