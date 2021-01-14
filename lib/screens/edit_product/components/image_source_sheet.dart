import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {
  final Function(File) onImageSelected;
  final ImagePicker picker = ImagePicker();

  ImageSourceSheet({this.onImageSelected});

  @override
  Widget build(BuildContext context) {
    void editImage(String path) async{
      final File croppedFile = await ImageCropper.cropImage(
          sourcePath: path,
          aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
          androidUiSettings: AndroidUiSettings(
            toolbarTitle: "Editar image",
            toolbarColor: Theme.of(context).primaryColor,
            toolbarWidgetColor: Colors.white,
          ),
          iosUiSettings: IOSUiSettings(
              title: "Editar imagem",
              cancelButtonTitle: "Cancelar",
              doneButtonTitle: "Concluir"),
      );
      if(croppedFile != null) {
        onImageSelected(croppedFile);
      }
    }

    if (Platform.isAndroid)
      return BottomSheet(
          onClosing: () {},
          builder: (_) => Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FlatButton(
                      onPressed: () async {
                        final PickedFile file =
                            await picker.getImage(source: ImageSource.camera);
                        editImage(file.path);
                      },
                      child: Text("Camera")),
                  FlatButton(
                      onPressed: () async {
                        final PickedFile file =
                            await picker.getImage(source: ImageSource.gallery);
                        editImage(file.path);
                      },
                      child: Text("Galeria")),
                ],
              ));
    else
      return CupertinoActionSheet(
        title: Text("Selecionar foto para o item"),
        message: Text("Escolha a origem da foto"),
        cancelButton: CupertinoActionSheetAction(
          child: Text("Cancelar"),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          CupertinoActionSheetAction(
              onPressed: () async {
                final PickedFile file =
                    await picker.getImage(source: ImageSource.camera);
                editImage(file.path);
              },
              isDefaultAction: true,
              child: Text("Camera")),
          CupertinoActionSheetAction(
              onPressed: () async {
                final PickedFile file =
                    await picker.getImage(source: ImageSource.camera);
                editImage(file.path);
              },
              child: Text("Galeria")),
        ],
      );
  }
}
