import 'package:UUL_Gym/models/app_state.dart';
import 'package:UUL_Gym/models/gym.dart';
import 'package:UUL_Gym/widgets/selector/horizontal_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GymList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, appState, child) {
      return HorizontalSelector<Gym>(
        items: appState.gyms,
        onItemTap: appState.changeActiveGym,
        isItemSelected: (gym) => gym.id == appState.activeGymId,
        textScale: 2,
        indicatorScale: 1.2,
      );
    });
  }
}
