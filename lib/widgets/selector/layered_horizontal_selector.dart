import 'package:UUL_Gym/common/has_title.dart';
import 'package:UUL_Gym/widgets/selector/horizontal_selector.dart';
import 'package:flutter/material.dart';


class LayeredHorizontalSelector<T extends HasTitle> extends StatelessWidget {
  final double itemRightSpacing;
  final double indicatorScale;
  final double textScale;
  final List<T> items;
  final Function(T) onItemTap;
  final bool Function(T) isItemSelected;
  final int itemsPerRow;

  LayeredHorizontalSelector({this.items, this.onItemTap, this.isItemSelected, this.itemRightSpacing, this.indicatorScale, this.textScale, this.itemsPerRow = 4});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _getLayeredSelectors(),
    );
  }

  HorizontalSelector<T> _getSelector({int startIndex, int endIndex}) {
    return HorizontalSelector<T>(
      items: endIndex == null ? items.sublist(startIndex) : items.sublist(startIndex, endIndex),
      onItemTap: onItemTap,
      isItemSelected: isItemSelected,
      itemRightSpacing: itemRightSpacing,
      textScale: textScale,
      indicatorScale: indicatorScale,
    );
  }

  List<Widget> _getLayeredSelectors() {
    // if (viewModel.activeTower.isEmpty) {
    //   return [];
    // }
    // if (viewModel.activeTower.getTitle() == "A" || viewModel.activeTower.getTitle() == "B") {
    //   return [_getSelector(0, 4), _getSelector(5, 9)];
    // } else {
    //   return [_getSelector(0, 4), _getSelector(5, 9), _getSelector(10, 11)];
    // }
    var result = List<Widget>();
    int i = 0;
    var remainder = items.length % itemsPerRow;
    while (i < items.length - remainder) {
      result.add(_getSelector(startIndex: i, endIndex: i + itemsPerRow));
      i = i + itemsPerRow;
    }
    if (remainder != 0) {
      result.add(_getSelector(startIndex: items.length - remainder));
    }
    return result;
  }
}
