import 'package:flutter/material.dart';
import 'package:flutter_loja_ultimo/common/custom_icon_button.dart';
import 'package:flutter_loja_ultimo/models/item_size.dart';

class EditItemSize extends StatelessWidget {
  final ItemSize size;

  const EditItemSize({Key key, this.size, this.onRemove, this.onMoveUp, this.onMoveDown}): super(key: key);

  final VoidCallback onRemove;
  final VoidCallback onMoveUp;
  final VoidCallback onMoveDown;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 30,
          child: TextFormField(
            validator: (name){
              if(name.isEmpty)
                return "Invalido";
              return null;
            },
            initialValue: size.name,
            decoration: InputDecoration(
              labelText: "Titulo",
              isDense: true,
            ),
            onChanged: (name) => size.name = name,
          ),
        ),
        SizedBox(width: 4,),
        Expanded(
          flex: 30,
          child: TextFormField(
            validator: (stock){
              if(int.tryParse(stock) == null)
                return "Invalido";
              return null;
            },
            initialValue: size.stock?.toString(),
            decoration: InputDecoration(
              labelText: "Estoque",
              isDense: true,
            ),
            keyboardType: TextInputType.number,
            onChanged: (stock) => size.stock = int.tryParse(stock),
          ),
        ),
        SizedBox(width: 4,),
        Expanded(
          flex: 40,
          child: TextFormField(
            validator: (price){
              if(num.tryParse(price) == null)
                return "Invalido";
              return null;
            },
            initialValue: size.price?.toStringAsFixed(2),
            decoration: InputDecoration(
              labelText: "Preço",
              isDense: true,
              prefixText: "R\$ "
            ),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onChanged: (price) => size.price = num.tryParse(price),
          ),
        ),
        CustomIconButton(
          iconData: Icons.remove,
          color: Colors.red,
          onTap: (){
            onRemove();
          },
        ),
        CustomIconButton(
          iconData: Icons.arrow_drop_up,
          color: Colors.black,
          onTap: onMoveUp,
        ),
        CustomIconButton(
          iconData: Icons.arrow_drop_down,
          color: Colors.black87,
          onTap: onMoveDown,
        ),
      ],
    );
  }
}
