import 'package:flutter/material.dart';
import 'package:flutter_loja_ultimo/models/product.dart';

import 'components/images_form.dart';

class EditProductScreen extends StatelessWidget {

  final Product product;

  const EditProductScreen(this.product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar anuncio"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ImagesForm(product),
        ],
      ),
    );
  }
}
