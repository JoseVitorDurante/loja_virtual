import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_loja_ultimo/models/address.dart';
import 'package:flutter_loja_ultimo/models/cart_manager.dart';
import 'package:provider/provider.dart';

class AddressInputField extends StatelessWidget {
  final Address address;

  const AddressInputField(this.address);

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    final cartManager = context.watch<CartManager>();

    if (address.zipCode != null && cartManager.deliveryPrice == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            enabled: !cartManager.loading,
            initialValue: address.street,
            decoration: InputDecoration(
                isDense: true,
                labelText: "Rua/avenida",
                hintText: "Av. Brasil"),
            validator: emptyValidator,
            onSaved: (t) => address.street = t,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  enabled: !cartManager.loading,
                  initialValue: address.number,
                  decoration: InputDecoration(
                      isDense: true, labelText: "Numero", hintText: "123"),
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  validator: emptyValidator,
                  onSaved: (t) => address.number = t,
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: TextFormField(
                  enabled: !cartManager.loading,
                  autocorrect: false,
                  initialValue: address.complement,
                  decoration: InputDecoration(
                      isDense: true,
                      labelText: "Complemneto",
                      hintText: "Opcional"),
                  onSaved: (t) => address.complement = t,
                ),
              ),
            ],
          ),
          TextFormField(
            enabled: !cartManager.loading,
            initialValue: address.district,
            decoration: InputDecoration(
                isDense: true, labelText: "Bairro", hintText: "Guanabara"),
            validator: emptyValidator,
            onSaved: (t) => address.district = t,
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: TextFormField(
                  initialValue: address.city,
                  decoration: InputDecoration(
                      isDense: true, labelText: "Cidade", hintText: "Campinas"),
                  keyboardType: TextInputType.number,
                  enabled: false,
                  onSaved: (t) => address.city = t,
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: TextFormField(
                  initialValue: address.state,
                  decoration: InputDecoration(
                      isDense: true,
                      labelText: "UF",
                      counterText: "",
                      hintText: "Sp"),
                  maxLength: 2,
                  onSaved: (t) => address.state = t,
                  enabled: false,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          if(cartManager.loading)
            LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation(primaryColor),
              backgroundColor: Colors.transparent,
            ),
          RaisedButton(
            onPressed: !cartManager.loading
                ? () async {
                    if (Form.of(context).validate()) {
                      Form.of(context).save();
                      try {
                        await context.read<CartManager>().setAddress(address);
                      } catch (e) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(
                            "$e",
                          ),
                          backgroundColor: Colors.red,
                        ));
                      }
                    }
                  }
                : null,
            child: Text("Calcular frete"),
            color: primaryColor,
            textColor: Colors.white,
          ),
        ],
      );
    } else if (address.zipCode != null) {
      return Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: Text("${address.street}, "
            "${address.number}, \n"
            "${address.district}, \n"
            "${address.city}, "
            "${address.state}, "),
      );
    } else {
      return Container();
    }
  }

  // ignore: missing_return
  String emptyValidator(String value) {
    if (value.isEmpty) return "Campo obrigatorio";
  }
}
