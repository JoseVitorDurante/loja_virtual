import 'package:flutter/material.dart';

import 'components/address_card.dart';

class AddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Entrega"),
      ),
      body: ListView(
        children: [
          AddressCard(),
        ],
      ),
    );  }
}
