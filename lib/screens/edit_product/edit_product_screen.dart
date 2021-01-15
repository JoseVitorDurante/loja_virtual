import 'package:flutter/material.dart';
import 'package:flutter_loja_ultimo/models/product.dart';

import 'components/images_form.dart';
import 'components/sizes_form.dart';

class EditProductScreen extends StatelessWidget {
  final Product product;

  final bool editig;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  EditProductScreen(Product p) :editig = p != null, product = p != null ? p.clone() : Product();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(editig ? "Editar produto" : "Criar produto"),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            ImagesForm(product),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    initialValue: product.name,
                    decoration: InputDecoration(
                      hintText: "Titulo",
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    validator: (name) {
                      if (name.length < 3) return "Titulo muito curto";
                      return null;
                    },
                    onChanged: (name) => product.name = name,
                  ),
                  Text(
                    "A partir de ",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    "R\$ ... ",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      "Descrição ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  TextFormField(
                    initialValue: product.description,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Descrição",
                    ),
                    maxLines: null,
                    validator: (desc) {
                      if (desc.length < 6) return "Descrição muito curta";
                      return null;
                    },
                    onChanged: (desc) => product.description = desc,
                  ),
                  SizesForm(product),
                  SizedBox(height: 20,),
                  SizedBox(
                    height: 44,
                    child: RaisedButton(
                      color: primaryColor,
                      disabledColor: primaryColor.withAlpha(100),
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                            formKey.currentState.save();
                            product.save();
                        }
                      },
                      child: Text("Salvar", style: TextStyle(fontSize: 18, color: Colors.white),),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
