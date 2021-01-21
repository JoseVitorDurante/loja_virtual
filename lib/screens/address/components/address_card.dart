import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loja_ultimo/models/address.dart';
import 'package:flutter_loja_ultimo/models/cart_manager.dart';
import 'package:provider/provider.dart';

import 'address_input_field.dart';
import 'cep_input_field.dart';

class AddressCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
          child: Consumer<CartManager>(builder: (_, cartManager, __) {
            final address = cartManager.address ?? Address();

            return Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Endereço de entrega",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  CepInputField(address),
                  AddressInputField(address),
                ],
              ),
            );
          })),
    );
  }
}
