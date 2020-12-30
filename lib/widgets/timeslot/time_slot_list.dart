import 'file:///C:/local/flutter/UUL_Gym/lib/widgets/timeslot/time_slot_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:UUL_Gym/models/app_state.dart';

class TimeSlotList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, appState, child) {
      return ListView.builder(
        itemBuilder: (context, index) => TimeSlotTile(
          timeSlot: appState.getCurrentDateTimeSlots()[index],
          isCurrentDay: appState.isCurrentDateActive,
          rules: appState.rules,
        ),
        itemCount: appState.getCurrentDateTimeSlots().length,
      );
    });
  }
}
