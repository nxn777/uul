import 'package:UUL_Gym/models/tower.dart';
import 'package:UUL_Gym/screens/newprofile/new_profile_viewmodel.dart';
import 'package:UUL_Gym/widgets/selector/horizontal_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:UUL_Gym/constants/dimens.dart';

class TowerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<NewProfileViewModel>(builder: (context, viewModel, child) {
      return HorizontalSelector<Tower>(
        items: viewModel.towers,
        onItemTap: viewModel.changeActiveTower,
        isItemSelected: (tower) => tower.id == viewModel.activeTowerId,
        itemRightSpacing: kSpacingXXLarge,
        textScale: 2,
        indicatorScale: 1.2,
      );
    });
  }
}
