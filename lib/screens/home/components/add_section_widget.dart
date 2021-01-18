import 'package:flutter/material.dart';
import 'package:flutter_loja_ultimo/models/home_manager.dart';
import 'package:flutter_loja_ultimo/models/section.dart';

class AddSectionWidget extends StatelessWidget {
  final HomeManager homeManager;

  const AddSectionWidget(this.homeManager);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: FlatButton(
          onPressed: (){
            homeManager.addSection(Section(type: "List"));
          },
          textColor: Colors.white,
          child: Text("Adicionar lista"),
        ),) ,
        Expanded(child: FlatButton(
          onPressed: (){
            homeManager.addSection(Section(type: "Staggered"));
          },
          textColor: Colors.white,
          child: Text("Adicionar grade"),
        ),) ,
      ],
    );
  }
}
