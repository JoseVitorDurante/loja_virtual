import 'package:flutter/material.dart';
import 'package:flutter_loja_ultimo/common/custom_drawer/custom_drawer.dart';
import 'package:flutter_loja_ultimo/models/product_manager.dart';
import 'package:flutter_loja_ultimo/screens/products/components/product_list_title.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text("Produtos"),
        centerTitle: true,
      ),
      body: Consumer<ProductManager>(builder: (_, productManager, __) {
        return ListView.builder(
            padding: EdgeInsets.all(4),
            itemCount: productManager.allProducts.length,
            itemBuilder: (_, index) {
              return ProductListTile(
                product: productManager.allProducts[index],
              );
            });
      }),
    );
  }
}
