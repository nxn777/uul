import 'package:UUL_Gym/models/time_slot.dart';
import 'package:flutter/material.dart';

class TimeSlotTile extends StatelessWidget {
  final TimeSlot timeSlot;
  
  TimeSlotTile({this.timeSlot});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(timeSlot.start),
    );
  }
}
