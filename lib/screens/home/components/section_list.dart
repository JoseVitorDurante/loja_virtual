import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loja_ultimo/models/home_manager.dart';
import 'package:flutter_loja_ultimo/models/section.dart';
import 'package:flutter_loja_ultimo/screens/home/components/item_tile.dart';
import 'package:flutter_loja_ultimo/screens/home/components/section_header.dart';
import 'package:provider/provider.dart';

import 'add_tile_widget.dart';

class SectionList extends StatelessWidget {
  final Section section;

  const SectionList(this.section);

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(section),
          SizedBox(
            height: 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: homeManager.editing
                  ? section.items.length + 1
                  : section.items.length,
              itemBuilder: (_, index) {
                if (index < section.items.length)
                  return ItemTile(section.items[index]);
                else
                  return AddTileWidget();
              },
              separatorBuilder: (_, __) => SizedBox(
                width: 4,
              ),
            ),
          )
        ],
      ),
    );
  }
}
