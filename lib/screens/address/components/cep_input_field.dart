import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_loja_ultimo/services/cepaberto_service.dart';

class CepInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          decoration: InputDecoration(
            isDense: true,
            labelText: "CEP",
            hintText: "12.345-768",
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
        RaisedButton(
          onPressed: () {
            CepAbertoService().getAddressFromCep("15105000").then((value) => print(value.toString()));
          },
          color: primaryColor,
          textColor: Colors.white,
          disabledColor: primaryColor.withAlpha(100),
          child: Text("Buscar cep"),
        ),
      ],
    );
  }
}
