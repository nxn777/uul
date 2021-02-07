import 'package:core/core.dart';
import 'horizontal_selector_tile.dart';
import 'package:flutter/material.dart';

class HorizontalSelector<T extends HasTitle> extends StatelessWidget {
  final double itemRightSpacing;
  final double indicatorScale;
  final double textScale;
  final List<T> items;
  final Function(T) onItemTap;
  final bool Function(T) isItemSelected;

  HorizontalSelector({this.items, this.onItemTap, this.isItemSelected, this.itemRightSpacing, this.indicatorScale, this.textScale});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _getTiles(),
    );
  }

  List<Widget> _getTiles() => items
      .map((item) => HorizontalSelectorTile(
            item: item,
            onTap: onItemTap,
            isSelected: isItemSelected(item),
            itemRightSpacing: itemRightSpacing,
            textScale: textScale,
            indicatorScale: indicatorScale,
          ))
      .toList();
}

class StringSelectorItem implements HasTitle {
  String value;

  StringSelectorItem(this.value);

  @override
  String getTitle({bool raw = false}) => value;
}

extension SelectorHelpers on List<String> {
  List<StringSelectorItem> toSelectorItems() => this.map((e) => StringSelectorItem(e)).toList();
}
