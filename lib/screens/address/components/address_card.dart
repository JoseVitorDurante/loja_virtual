import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cep_input_field.dart';

class AddressCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Endereço de entrega", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),),
            CepInputField(),
          ],
        ),
      ),
    );
  }
}
