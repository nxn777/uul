import 'package:flutter/material.dart';
import 'package:UUL_Gym/constants/color_constants.dart';
import 'package:UUL_Gym/constants/text_style_constants.dart';
import 'package:intl/intl.dart';
import 'package:UUL_Gym/constants/dimens.dart';

class DayTile extends StatelessWidget {
  final Function(DateTime) onTap;
  final bool isSelected;
  final bool isCurrent;
  final DateTime day;
  final DateFormat _dayFormatter;
  DayTile({@required this.day, @required this.isSelected, @required this.isCurrent, @required this.onTap})
      : _dayFormatter = DateFormat("E");

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(day);
      },
      child: Container(
        child: Text(
          _dayFormatter.format(day).toUpperCase(),
          style: _getTextStyle(),
          textAlign: TextAlign.center,
        ),
        padding: EdgeInsets.fromLTRB(8, 12, 8, 12),
        width: 44,
        decoration: BoxDecoration(
          color: isSelected ? kAccentColor : Colors.transparent,
          borderRadius: BorderRadius.circular(kDefaultBorderRadius),
        ),
      ),
    );
  }

  TextStyle _getTextStyle() {
    var _style =  isSelected
        ? kRegularActiveTextStyle.copyWith(fontWeight: FontWeight.bold)
        : kRegularInactiveTextStyle.copyWith(fontWeight: FontWeight.bold);
    return isCurrent ? _style.copyWith(color: Colors.black) : _style;
  }
}
