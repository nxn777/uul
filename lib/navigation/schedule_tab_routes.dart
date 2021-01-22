import 'package:UUL_Gym/navigation/tab_routes.dart';
import 'package:UUL_Gym/screens/timeslots/time_slot_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ScheduleTabRoutes extends TabRoutes {
  static const String root = '/';
  @override
  String defaultRoute = root;

  @override
  Map<String, WidgetBuilder> routeBuilders(BuildContext context) {
    return {ScheduleTabRoutes.root: (context) => TimeSlotScreen()};
  }
}
