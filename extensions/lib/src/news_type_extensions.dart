import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:common/common.dart';

extension Helpers on NewsType {
  IconData getIcon() {
    IconData result;
    switch (this) {
      case NewsType.INFO:
        result = FontAwesomeIcons.info;
        break;
      case NewsType.ALERT:
        result = FontAwesomeIcons.exclamationTriangle;
        break;
      case NewsType.CALL_TO_ACTION:
        result = FontAwesomeIcons.solidBell;
        break;
      case NewsType.POLL:
        result = FontAwesomeIcons.poll;
        break;
      case NewsType.REMINDER:
        result = FontAwesomeIcons.angleDoubleUp;
        break;
    }
    return result;
  }

  Color getIconColor() {
    if ([NewsType.ALERT].contains(this)) {
      return Colors.redAccent;
    } else {
      return kAccentColor;
    }
  }

  String getName() {
    switch (this) {
      case NewsType.INFO:
        return "Information";
        break;
      case NewsType.ALERT:
        return "Alert";
        break;
      case NewsType.CALL_TO_ACTION:
        return "Call to action";
        break;
      case NewsType.POLL:
        return "Poll";
        break;
      case NewsType.REMINDER:
        return "Reminder";
        break;
    }
    return "Unknown";
  }
}