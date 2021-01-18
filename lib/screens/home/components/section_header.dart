import 'package:flutter/material.dart';
import 'package:flutter_loja_ultimo/common/custom_icon_button.dart';
import 'package:flutter_loja_ultimo/models/home_manager.dart';
import 'package:flutter_loja_ultimo/models/section.dart';
import 'package:provider/provider.dart';

class SectionHeader extends StatelessWidget {
  final Section section;

  const SectionHeader(this.section);

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();
    if (homeManager.editing) {
      return Row(
        children: [
          Expanded(
            child: TextFormField(
              initialValue: section.name,
              decoration: InputDecoration(
                hintText: "Titulo",
                isDense: true,
                border: InputBorder.none,
              ),
              style: TextStyle(
                  color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800),
              onSaved: (text) => section.name = text,
            ),
          ),
          CustomIconButton(
            iconData: Icons.remove,
            color: Colors.white,
            onTap: (){
              homeManager.removeSection(section);
            },
          ),
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          section.name ?? "",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800),
        ),
      );
    }
  }
}
