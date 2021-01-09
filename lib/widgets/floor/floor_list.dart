import 'package:UUL_Gym/models/floor.dart';
import 'package:UUL_Gym/screens/newprofile/new_profile_viewmodel.dart';
import 'package:UUL_Gym/widgets/selector/horizontal_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:UUL_Gym/constants/dimens.dart';

class FloorList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<NewProfileViewModel>(builder: (context, viewModel, child) {
      return Column(
        children: _getFloorSelectors(viewModel),
      );
    });
  }

  HorizontalSelector<Floor> _getSelector(int startIndex, int endIndex, NewProfileViewModel viewModel) {
    return HorizontalSelector<Floor>(
      items: viewModel.floors.sublist(startIndex, endIndex +1),
      onItemTap: viewModel.changeActiveFloor,
      isItemSelected: (floor) => floor.id == viewModel.activeFloorId,
      itemRightSpacing: kSpacingLarge,
      textScale: 2,
      indicatorScale: 1.2,
    );
  }

  List<Widget> _getFloorSelectors(NewProfileViewModel viewModel) {
    if (viewModel.activeTower.getTitle() == "A" || viewModel.activeTower.getTitle() == "B") {
      return [
        _getSelector(0, 4, viewModel),
        _getSelector(5, 9, viewModel)
      ];
    } else {
      return [
        _getSelector(0, 4, viewModel),
        _getSelector(5, 9, viewModel),
        _getSelector(10, 11, viewModel)
      ];
    }
  }
}
