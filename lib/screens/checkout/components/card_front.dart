import 'package:brasil_fields/brasil_fields.dart';
import 'package:credit_card_type_detector/credit_card_type_detector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_loja_ultimo/models/credit_card.dart';
import 'package:flutter_loja_ultimo/screens/checkout/components/card_text_field.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CardFront extends StatelessWidget {
  final MaskTextInputFormatter dateFormatter =
      MaskTextInputFormatter(mask: "##/####", filter: {"#": RegExp("[0-9]")});

  final FocusNode numberFocus;
  final FocusNode dateFocus;
  final FocusNode nameFocus;
  final VoidCallback finishedFront;
  final CreditCard creditCard;

  CardFront(
      {this.numberFocus,
      this.dateFocus,
      this.nameFocus,
      this.finishedFront,
      this.creditCard});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      elevation: 16,
      child: Container(
        padding: EdgeInsets.all(16),
        height: 200,
        color: Color(0xFF1B4B52),
        child: Row(
          children: [
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CardTextField(
                  initialValue: creditCard.number,
                  title: "Número",
                  hint: "0000 0000 0000 0000",
                  textInputType: TextInputType.number,
                  bold: true,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CartaoBancarioInputFormatter(),
                  ],
                  validator: (number) {
                    if (number.length != 19)
                      return "Invalido";

                    //validador de cartao
                    else if (detectCCType(number) == CreditCardType.unknown)
                      return "Cartão Invalido";

                    return null;
                  },
                  onSubmitted: (_) {
                    dateFocus.requestFocus();
                  },
                  focusNode: numberFocus,
                  onSaved: creditCard.setNumber,
                ),
                CardTextField(
                  initialValue: creditCard.expirationDate,
                  title: "Validade",
                  hint: "12/2029",
                  textInputType: TextInputType.number,
                  inputFormatters: [dateFormatter],
                  validator: (date) {
                    if (date.isEmpty || date.length != 7) return "Invalido";
                    return null;
                  },
                  onSubmitted: (_) {
                    nameFocus.requestFocus();
                  },
                  focusNode: dateFocus,
                  onSaved: (date) {
                    creditCard.setexpirationDate(date);
                  },
                ),
                CardTextField(
                  initialValue: creditCard.holder,
                  title: "Titular",
                  hint: "Joao Silva",
                  textInputType: TextInputType.text,
                  bold: true,
                  validator: (name) {
                    if (name.isEmpty) return "Invalido";
                    return null;
                  },
                  onSubmitted: (_) {
                    finishedFront();
                  },
                  focusNode: nameFocus,
                  onSaved: creditCard.setHolder,
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
