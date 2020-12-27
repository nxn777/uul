import 'package:UUL_Gym/widgets/gym/gym_list.dart';
import 'package:UUL_Gym/widgets/week/day_list_animated.dart';
import 'package:flutter/material.dart';
import 'package:UUL_Gym/constants/dimens.dart';

class TimeSlotScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(kSpacingMedium,  kSpacingLarge,  kSpacingMedium,  kSpacingLarge),
              child: Text("Schedule"),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(kSpacingMedium, 0, kSpacingMedium, kSpacingMedium),
              child: GymList(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(kSpacingMedium, kSpacingMedium, kSpacingMedium, kSpacingMedium),
              child: DayListAnimated(),
            )
          ],
        ),
      )
    );
  }
}
