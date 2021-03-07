import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:common/common.dart';
import 'package:i18n/i18n.dart';

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
        return "Information".i18n;
        break;
      case NewsType.ALERT:
        return "Alert".i18n;
        break;
      case NewsType.CALL_TO_ACTION:
        return "Call to action".i18n;
        break;
      case NewsType.POLL:
        return "Poll".i18n;
        break;
      case NewsType.REMINDER:
        return "Reminder".i18n;
        break;
    }
    return "Unknown".i18n;
  }
}