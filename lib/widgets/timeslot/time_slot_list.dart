import 'package:UUL_Gym/models/app_state.dart';
import 'package:UUL_Gym/models/time_slot.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'file:///C:/local/flutter/UUL_Gym/lib/widgets/timeslot/time_slot_tile.dart';

class TimeSlotList extends StatelessWidget {
  final Function(TimeSlot) onTap;

  TimeSlotList({@required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, appState, child) {
      return ListView.builder(
        itemBuilder: (context, index) => TimeSlotTile(
          timeSlot: appState.getCurrentDateTimeSlots()[index],
          isCurrentDay: appState.isCurrentDateActive,
          rules: appState.rules,
          onTap: onTap,
        ),
        itemCount: appState.getCurrentDateTimeSlots().length,
      );
    });
  }
}
