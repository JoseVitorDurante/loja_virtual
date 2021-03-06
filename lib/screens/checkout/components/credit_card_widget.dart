import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loja_ultimo/models/credit_card.dart';
import "package:flutter_loja_ultimo/screens/checkout/components/card_back.dart";
import "package:flutter_loja_ultimo/screens/checkout/components/card_front.dart";

class CreditCardWidget extends StatelessWidget {
  final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  final FocusNode numberFocus = FocusNode();
  final FocusNode dateFocus = FocusNode();
  final FocusNode nameFocus = FocusNode();
  final FocusNode cvvFocus = FocusNode();

  final CreditCard creditCard;

  CreditCardWidget(this.creditCard);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FlipCard(
            direction: FlipDirection.HORIZONTAL,
            speed: 700,
            key: cardKey,
            flipOnTouch: false,
            front: CardFront(
                dateFocus: dateFocus,
                nameFocus: nameFocus,
                numberFocus: numberFocus,
                creditCard: creditCard,
                finishedFront: () {
                  cardKey.currentState.toggleCard();
                  cvvFocus.requestFocus();
                }),
            back: CardBack(
              creditCard: creditCard,
              cvvFocus: cvvFocus,
            ),
          ),
          FlatButton(
              onPressed: () {
                cardKey.currentState.toggleCard();
              },
              child: Text("Virar cartão"))
        ],
      ),
    );
  }
}
