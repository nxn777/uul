import 'dart:ui';

import 'package:arch_components/arch_components.dart';
import 'package:common/common.dart';
import 'time_slot_screen_builder.dart';
import 'time_slots_screen_object.dart';
import 'time_slots_viewmodel.dart';
import 'package:widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'book/book_time_slot_screen.dart';

class TimeSlotScreen extends StatelessWidget with ViewStateScreen<TimeSlotsViewModel> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TimeSlotsViewModel>(
      create: (context) => TimeSlotsScreenBuilder.buildAndStartVM(context),
      child: Consumer<TimeSlotsViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            body: SafeArea(
              child: buildBody(viewModel, context),
            ),
          );
        },
      ),
    );
  }

  Widget buildIdleState(TimeSlotsViewModel viewModel, BuildContext context) {
    TimeSlotsScreenObject screenObject = viewModel.viewState.value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ScreenTitle("Schedule"),
        Padding(
          padding: const EdgeInsets.fromLTRB(kSpacingMedium, 0, kSpacingMedium, kSpacingMedium),
          child: GymList(
            gyms: screenObject.gyms,
            onGymTapped: viewModel.changeActiveGym,
            gymSelectedChecker: (gym) => gym.id == screenObject.activeGymId,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(kSpacingMedium, kSpacingMedium, kSpacingMedium, kSpacingMedium),
          child: DayListAnimated(
            currentWeek: screenObject.currentWeek,
            activeDate: screenObject.activeDate,
            currentDate: screenObject.currentDate,
            onTap: viewModel.changeActiveDate,
          ),
        ),
        Expanded(
          child: TimeSlotList(
            timeSlots: screenObject.timeSlots,
            isCurrentDateActive: screenObject.isCurrentDateActive,
            rules: screenObject.rules,
            onTap: (timeSlot) {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: .7, sigmaY: .7),
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + kBottomNavBarHeight),
                      child: BookTimeSlotScreen(
                        timeSlot: timeSlot,
                        gymTitle: screenObject.activeGym.getTitle(),
                        placesLeft: screenObject.rules.personsPerTimeSlot - timeSlot.occupiedBy.length,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
