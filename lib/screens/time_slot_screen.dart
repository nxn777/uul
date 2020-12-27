import 'package:UUL_Gym/widgets/week/day_list.dart';
import 'package:UUL_Gym/widgets/week/day_list_animated.dart';
import 'package:flutter/material.dart';

class TimeSlotScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16,  24,  16,  24.0),
              child: Text("Schedule"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DayListAnimated(),
            )
          ],
        ),
      )
    );
  }
}
