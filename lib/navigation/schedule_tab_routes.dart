import 'package:UUL_Gym/navigation/tab_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timeslots_presentation/timeslots_presentation.dart';

class ScheduleTabRoutes extends TabRoutes {
  static const String root = '/';
  @override
  String defaultRoute = root;

  @override
  Map<String, WidgetBuilderWrapper> routeBuilders(BuildContext context) {
    return {ScheduleTabRoutes.root: (_) => (context) => TimeSlotScreen()};
  }
}
