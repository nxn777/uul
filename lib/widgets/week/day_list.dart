import 'package:UUL_Gym/common/date_helpers.dart';
import 'package:UUL_Gym/models/app_state.dart';
import 'package:UUL_Gym/models/week.dart';
import 'package:UUL_Gym/widgets/week/day_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DayList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, appState, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _getDayTiles(appState.currentWeek, appState.activeDate, appState.currentDate, (day) => {appState.changeActiveDate(day)}),
      );
    });
  }

  List<Widget> _getDayTiles(Week week, DateTime activeDate, DateTime currentDate, Function(DateTime) onTap) => week.days
      .map((d) => DayTile(
            day: d,
            isSelected: DateHelpers.isTheSameDay(d, activeDate),
            isCurrent: DateHelpers.isTheSameDay(d, currentDate),
            onTap: onTap,
          ))
      .toList();
}
