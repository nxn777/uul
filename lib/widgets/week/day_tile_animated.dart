import 'package:UUL_Gym/common/date_helpers.dart';
import 'package:UUL_Gym/constants/animation_constants.dart';
import 'package:UUL_Gym/constants/color_constants.dart';
import 'package:UUL_Gym/constants/dimens.dart';
import 'package:UUL_Gym/constants/text_style_constants.dart';
import 'package:UUL_Gym/models/app_state.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DayTileAnimated extends StatefulWidget {
  final DateTime day;
  final DateFormat _dayFormatter;
  DayTileAnimated({@required this.day}) : _dayFormatter = DateFormat("E");
  @override
  _DayTileAnimatedState createState() => _DayTileAnimatedState();
}

class _DayTileAnimatedState extends State<DayTileAnimated> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, appState, child) {
      return GestureDetector(
        onTap: () {
          Provider.of<AppState>(context, listen: false).changeActiveDate(widget.day);
        },
        child: AnimatedContainer(
          child: Text(
            widget._dayFormatter.format(widget.day).toUpperCase(),
            style: _getTextStyle(),
            textAlign: TextAlign.center,
          ),
          padding: EdgeInsets.fromLTRB(8, 12, 8, 12),
          width: 44,
          duration: Duration(milliseconds: kStandardAnimationDurationMS),
          decoration: BoxDecoration(
            color: _isSelected() ? kAccentColor : Colors.transparent,
            borderRadius: BorderRadius.circular(kDefaultBorderRadius),
          ),
        ),
      );
    });
  }

  bool _isSelected() => DateHelpers.isTheSameDay(Provider.of<AppState>(context, listen: false).activeDate, widget.day);
  bool _isCurrent() => DateHelpers.isTheSameDay(Provider.of<AppState>(context, listen: false).currentDate, widget.day);

  TextStyle _getTextStyle() {
    var _style = _isSelected() ? kRegularActiveTextStyle.copyWith(fontWeight: FontWeight.w900) : kRegularInactiveTextStyle.copyWith(fontWeight: FontWeight.w900);
    return _isCurrent() ? _style.copyWith(color: Colors.black) : _style;
  }
}
