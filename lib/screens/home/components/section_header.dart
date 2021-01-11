import 'package:flutter/material.dart';
import 'package:flutter_loja_ultimo/models/section.dart';

class SectionHeader extends StatelessWidget {
  final Section section;

  const SectionHeader(this.section);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        section.name,
        style: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800),
      ),
    );
  }
}
