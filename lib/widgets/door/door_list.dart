import 'package:UUL_Gym/constants/dimens.dart';
import 'package:UUL_Gym/models/door_number.dart';
import 'package:UUL_Gym/screens/newprofile/new_profile_viewmodel.dart';
import 'package:UUL_Gym/widgets/selector/horizontal_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoorList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<NewProfileViewModel>(builder: (context, viewModel, child) {
      return Column(
        children: _getDoorSelectors(viewModel),
      );
    });
  }

  HorizontalSelector<Door> _getSelector(int startIndex, int endIndex, NewProfileViewModel viewModel) {
    return HorizontalSelector<Door>(
      items: viewModel.doors.sublist(startIndex, endIndex + 1),
      onItemTap: viewModel.changeActiveDoor,
      isItemSelected: (door) => door.id == viewModel.activeDoorId,
      itemRightSpacing: kSpacingLarge,
      textScale: 2,
      indicatorScale: 1.2,
    );
  }

  List<Widget> _getDoorSelectors(NewProfileViewModel viewModel) => [_getSelector(0, 3, viewModel), _getSelector(4, 7, viewModel)];
}
