import 'package:UUL_Gym/models/week.dart';
import 'package:UUL_Gym/widgets/week/day_tile_animated.dart';
import 'package:flutter/material.dart';

class DayListAnimated extends StatelessWidget {
  final Week currentWeek;
  final DateTime activeDate;
  final DateTime currentDate;
  final void Function(DateTime) onTap;

  DayListAnimated({@required this.currentWeek, @required this.activeDate, @required this.currentDate, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: currentWeek.days
          .map((d) => DayTileAnimated(
                day: d,
                activeDate: this.activeDate,
                currentDate: currentDate,
                onTap: onTap,
              ))
          .toList(),
    );
  }
}
