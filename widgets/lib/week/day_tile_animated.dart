import 'package:common/common.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DayTileAnimated extends StatefulWidget {
  final DateTime day;
  final DateFormat _dayFormatter;
  final void Function(DateTime) onTap;
  final DateTime activeDate;
  final DateTime currentDate;

  DayTileAnimated(this._dayFormatter, {@required this.day, @required this.activeDate, @required this.currentDate, @required this.onTap});

  @override
  _DayTileAnimatedState createState() => _DayTileAnimatedState();
}

class _DayTileAnimatedState extends State<DayTileAnimated> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap(widget.day);
      },
      child: AnimatedContainer(
        child: Text(
          widget._dayFormatter.format(widget.day).toUpperCase(),
          style: _getTextStyle(),
          textAlign: TextAlign.center,
        ),
        padding: EdgeInsets.fromLTRB(8, 12, 8, 12),
        duration: Duration(milliseconds: kStandardAnimationDurationMS),
        decoration: BoxDecoration(
          color: _isSelected() ? kAccentColor : Colors.transparent,
          borderRadius: BorderRadius.circular(kDefaultBorderRadius),
        ),
      ),
    );
  }

  bool _isSelected() => widget.activeDate.isTheSameDay(widget.day);

  bool _isCurrent() => widget.currentDate.isTheSameDay(widget.day);

  TextStyle _getTextStyle() {
    var _style = _isSelected() ? kRegularActiveTextStyle.copyWith(fontWeight: FontWeight.w900) : kRegularInactiveTextStyle.copyWith(fontWeight: FontWeight.w900);
    return _isCurrent() ? _style.copyWith(color: Colors.black) : _style;
  }
}
