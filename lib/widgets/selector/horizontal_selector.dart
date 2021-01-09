import 'package:UUL_Gym/common/has_title.dart';
import 'package:UUL_Gym/widgets/selector/horizontal_selector_tile.dart';
import 'package:flutter/material.dart';

class HorizontalSelector<T extends HasTitle> extends StatelessWidget {
  final List<T> items;
  final Function(T) onItemTap;
  final bool Function(T) isItemSelected;

  HorizontalSelector({this.items, this.onItemTap, this.isItemSelected});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _getTiles(),
    );
  }

  List<Widget> _getTiles() => items.map((item) => HorizontalSelectorTile(item: item, onTap: onItemTap, isSelected: isItemSelected(item))).toList();
}
