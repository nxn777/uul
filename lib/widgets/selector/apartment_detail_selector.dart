import 'package:UUL_Gym/constants/dimens.dart';
import 'package:UUL_Gym/widgets/selector/layered_horizontal_selector.dart';
import 'package:flutter/material.dart';

import 'horizontal_selector.dart';

class ApartmentDetailSelector extends StatelessWidget {
  final List<String> items;
  final void Function(String) onItemTap;
  final String activeItem;

  ApartmentDetailSelector({@required this.items, @required this.onItemTap, @required this.activeItem});

  @override
  Widget build(BuildContext context) {
    return LayeredHorizontalSelector<StringSelectorItem>(
      items: items.toSelectorItems(),
      onItemTap: (item) => onItemTap(item.value),
      isItemSelected: (item) => item.value == activeItem,
      itemRightSpacing: kSpacingLarge,
      textScale: 2,
      indicatorScale: 1.2,
    );
  }
}
