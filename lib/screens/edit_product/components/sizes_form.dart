import 'package:flutter/material.dart';
import 'package:flutter_loja_ultimo/models/item_size.dart';
import 'package:flutter_loja_ultimo/models/product.dart';
import 'package:flutter_loja_ultimo/screens/edit_product/components/edit_item_size.dart';

class SizesForm extends StatelessWidget {

  final Product product;

  const SizesForm(this.product);
  @override
  Widget build(BuildContext context) {
    return FormField<List<ItemSize>>(
      initialValue: product.sizes,
      builder: (state){
        return Column(
          children: state.value.map((size){
            return EditItemSize(
              size: size
            );
          }).toList(),
        );
      },
    );

  }
}
