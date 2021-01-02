import 'package:UUL_Gym/models/app_state.dart';
import 'package:UUL_Gym/models/week.dart';
import 'package:UUL_Gym/widgets/week/day_tile_animated.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DayListAnimated extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, appState, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _getDayTiles(appState.currentWeek),
      );
    });
  }

  List<Widget> _getDayTiles(Week week) => week.days.map((d) => DayTileAnimated(day: d)).toList();
}
