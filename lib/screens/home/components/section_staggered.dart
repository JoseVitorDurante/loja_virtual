import 'package:flutter/material.dart';
import 'package:flutter_loja_ultimo/models/section.dart';
import 'package:flutter_loja_ultimo/screens/home/components/section_header.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SectionStaggered extends StatelessWidget {
  final Section section;

  const SectionStaggered(this.section);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(section),
          StaggeredGridView.countBuilder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            crossAxisCount: 4,
            itemCount: section.items.length,
            itemBuilder: (_, index) {
              return Image.network(
                section.items[index].image,
                fit: BoxFit.cover,
              );
            },
            staggeredTileBuilder: (index) => StaggeredTile.count(2, index.isEven ? 2 : 1),
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
          ),
        ],
      ),
    );
  }
}
