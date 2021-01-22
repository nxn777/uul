import 'package:UUL_Gym/models/rules.dart';
import 'package:UUL_Gym/models/time_slot.dart';
import 'package:UUL_Gym/widgets/timeslot/time_slot_tile.dart';
import 'package:flutter/material.dart';

class TimeSlotList extends StatelessWidget {
  final Function(TimeSlot) onTap;
  final List<TimeSlot> timeSlots;
  final bool isCurrentDateActive;
  final Rules rules;

  TimeSlotList({@required this.timeSlots, @required this.isCurrentDateActive, @required this.rules, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => TimeSlotTile(
        timeSlot: timeSlots[index],
        isCurrentDay: isCurrentDateActive,
        rules: rules,
        onTap: onTap,
      ),
      itemCount: timeSlots.length,
    );
  }
}
