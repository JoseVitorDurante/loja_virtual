import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_loja_ultimo/screens/checkout/components/card_text_field.dart';

class CardBack extends StatelessWidget {
  final FocusNode cvvFocus;

  const CardBack(this.cvvFocus);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 16,
      child: Container(
        height: 200,
        color: Color(0xFF1B4B52),
        child: Column(
          children: [
            Container(
              color: Colors.black,
              height: 40,
              margin: EdgeInsets.symmetric(vertical: 16),
            ),
            Row(
              children: [
                Expanded(
                  flex: 70,
                  child: Container(
                    color: Colors.grey[500],
                    margin: EdgeInsets.only(left: 12),
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: CardTextField(
                      title: "CVV",
                      hint: "123",
                      maxLenght: 3,
                      textInputType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      textAlign: TextAlign.end,
                      validator: (cvv) {
                        if (cvv.isEmpty || cvv.length != 3) return "Invalido";
                        return null;
                      },
                      focusNode: cvvFocus,
                    ),
                  ),
                ),
                Expanded(
                  flex: 30,
                  child: SizedBox(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
