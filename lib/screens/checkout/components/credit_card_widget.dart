import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import "package:flutter_loja_ultimo/screens/checkout/components/card_back.dart";
import "package:flutter_loja_ultimo/screens/checkout/components/card_front.dart";

class CreditCardWidget extends StatelessWidget {
  final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  final FocusNode numberFocus = FocusNode();
  final FocusNode dateFocus = FocusNode();
  final FocusNode nameFocus = FocusNode();
  final FocusNode cvvFocus = FocusNode();

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
            front: CardFront(numberFocus, dateFocus, nameFocus, () {
              cardKey.currentState.toggleCard();
              cvvFocus.requestFocus();
            }),
            back: CardBack(
              cvvFocus,
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
