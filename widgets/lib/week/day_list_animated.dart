import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:extensions/extensions.dart';

import 'day_tile_animated.dart';

class DayListAnimated extends StatelessWidget {
  final Week currentWeek;
  final DateTime activeDate;
  final DateTime currentDate;
  final void Function(DateTime) onTap;

  DayListAnimated({@required this.currentWeek, @required this.activeDate, @required this.currentDate, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _getDaysRowItems(context)
      ),
    );
  }

  List<Widget> _getDaysRowItems(BuildContext context) {
    var df = DateFormatter.createWeekDayFormat(context);
    List<Widget> result = [];
    currentWeek.days.forEach((d) {
      result.add(DayTileAnimated(
        df,
        day: d,
        activeDate: this.activeDate,
        currentDate: currentDate,
        onTap: onTap,
      ));
      result.add(SizedBox(width: kSpacingXSmall,));
    });
    return result;
  }
}
