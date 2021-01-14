import 'package:flutter/material.dart';
import 'package:flutter_loja_ultimo/models/item_size.dart';

class EditItemSize extends StatelessWidget {
  final ItemSize size;

  const EditItemSize({this.size});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            initialValue: size.name,
            decoration: InputDecoration(
              labelText: "Titulo",
              isDense: true,
            ),
          ),
        ),
        SizedBox(width: 4,),
        Expanded(
          child: TextFormField(
            initialValue: size.stock.toString(),
            decoration: InputDecoration(
              labelText: "Estoque",
              isDense: true,
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        SizedBox(width: 4,),
        Expanded(
          child: TextFormField(
            initialValue: size.price.toStringAsFixed(2),
            decoration: InputDecoration(
              labelText: "Preço",
              isDense: true,
            ),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
        ),
      ],
    );
  }
}
