import 'package:flutter/material.dart';
import 'package:flutter_loja_ultimo/common/custom_drawer/custom_drawer.dart';
import 'package:flutter_loja_ultimo/models/product_manager.dart';
import 'package:flutter_loja_ultimo/models/user_manager.dart';
import 'package:flutter_loja_ultimo/screens/products/components/product_list_title.dart';
import 'package:provider/provider.dart';

import 'components/search_dialog.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Consumer<ProductManager>(
          builder: (_, productManager, __) {
            if (productManager.search.isEmpty) {
              return Text("Produtos");
            } else {
              return LayoutBuilder(builder: (_, constraints) {
                constraints.biggest.width;
                return GestureDetector(
                  child: Container(
                      width: constraints.biggest.width,
                      child: Text(
                        productManager.search,
                        textAlign: TextAlign.center,
                      )),
                  onTap: () async {
                    final search = await showDialog<String>(
                        context: context,
                        builder: (_) =>
                            SearchDialog(initialText: productManager.search));
                    if (search != null) {
                      productManager.search = search;
                    }
                  },
                );
              });
            }
          },
        ),
        centerTitle: true,
        actions: [
          Consumer<ProductManager>(builder: (_, productManager, __) {
            if (productManager.search.isEmpty) {
              return IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () async {
                    final search = await showDialog<String>(
                        context: context,
                        builder: (_) => SearchDialog(
                              initialText: productManager.search,
                            ));
                    if (search != null) {
                      productManager.search = search;
                    }
                  });
            } else {
              return IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    productManager.search = "";
                  });
            }
          }),
          Consumer<UserManager>(
            builder: (_, userManager, __) {
              if (userManager.adminEnabled) {
                return IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        "/edit_product",
                      );
                    });
              } else {
                return Container();
              }
            },
          )
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.of(context).pushNamed("/cart");
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}
