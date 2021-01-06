import 'dart:ui';

import 'package:UUL_Gym/constants/dimens.dart';
import 'package:UUL_Gym/constants/text_style_constants.dart';
import 'package:UUL_Gym/screens/book_time_slot_screen.dart';
import 'package:UUL_Gym/widgets/gym/gym_list.dart';
import 'package:UUL_Gym/widgets/timeslot/time_slot_list.dart';
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
              padding: const EdgeInsets.fromLTRB(kSpacingMedium, kSpacingLarge, kSpacingMedium, kSpacingLarge),
              child: Text(
                "Schedule",
                style: kPageTitleTextStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(kSpacingMedium, 0, kSpacingMedium, kSpacingMedium),
              child: GymList(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(kSpacingMedium, kSpacingMedium, kSpacingMedium, kSpacingMedium),
              child: DayListAnimated(),
            ),
            Expanded(
              child: TimeSlotList(
                onTap: (timeSlot) {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + kBottomNavBarHeight),
                          child: BookTimeSlotScreen(
                            timeSlot: timeSlot,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

/**
    TimeSlotTile(
    timeSlot: TimeSlot(id: 0, start: DateTime.now(), end: DateTime.now().add(Duration(hours: 1)), occupiedBy: List.of({
    User(id: 1, name: "user1", appartment: Appartment(id: 1, code: "C1207")),
    //User(id: 2, name: "user2", appartment: Appartment(id: 1, code: "C1207")),
    //User(id: 3, name: "user3", appartment: Appartment(id: 3, code: "B0104")),
    User(id: 4, name: "user4", appartment: Appartment(id: 4, code: "D1002")),
    })),
    rules: Provider.of<AppState>(context, listen: false).rules,
    isCurrentDay: true,
    ),
    TimeSlotTile(
    timeSlot: TimeSlot(id: 0, start: DateTime.now(), end: DateTime.now().add(Duration(hours: 1)), occupiedBy: List.empty()),
    rules: Provider.of<AppState>(context, listen: false).rules,
    isCurrentDay: true,
    )
    **/
