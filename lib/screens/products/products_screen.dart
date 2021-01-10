import 'package:flutter/material.dart';
import 'package:flutter_loja_ultimo/common/custom_drawer/custom_drawer.dart';
import 'package:flutter_loja_ultimo/models/product_manager.dart';
import 'package:flutter_loja_ultimo/screens/products/components/product_list_title.dart';
import 'package:provider/provider.dart';

import 'components/search_dialog.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text("Produtos"),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                final search = await showDialog<String>(
                    context: context, builder: (_) => SearchDialog());
                if (search != null) {
                  context.read<ProductManager>().search = search;
                }
              }),
        ],
      ),
      body: Consumer<ProductManager>(builder: (_, productManager, __) {
        final filterProducts = productManager.filteredProduct;
        return ListView.builder(
            padding: EdgeInsets.all(4),
            itemCount: filterProducts.length,
            itemBuilder: (_, index) {
              return ProductListTile(
                product: filterProducts[index],
              );
            });
      }),
    );
  }
}
