import 'dart:ui';

import 'package:UUL_Gym/common/base_view_state.dart';
import 'package:UUL_Gym/constants/dimens.dart';
import 'package:UUL_Gym/constants/text_style_constants.dart';
import 'package:UUL_Gym/screens/timeslots/time_slot_screen_builder.dart';
import 'package:UUL_Gym/screens/timeslots/time_slots_screen_object.dart';
import 'package:UUL_Gym/screens/timeslots/time_slots_viewmodel.dart';
import 'package:UUL_Gym/widgets/gym/gym_list.dart';
import 'package:UUL_Gym/widgets/indicator/u_u_l_loading_indicator.dart';
import 'package:UUL_Gym/widgets/indicator/u_u_l_overlay_loading_indicator.dart';
import 'package:UUL_Gym/widgets/timeslot/time_slot_list.dart';
import 'package:UUL_Gym/widgets/week/day_list_animated.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'book/book_time_slot_screen.dart';

class TimeSlotScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TimeSlotsViewModel>(
      create: (context) => TimeSlotsScreenBuilder.buildAndStartVM(context),
      child: Consumer<TimeSlotsViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            body: SafeArea(
              child: _buildBody(viewModel, context),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(TimeSlotsViewModel viewModel, BuildContext context) {
    // print("Building: ${viewModel.viewState.status}");
    Widget body;
    switch (viewModel.viewState.status) {
      case ViewStatus.IDLE:
        body = _buildIdleState(viewModel, context);
        break;
      case ViewStatus.ERROR:
        body = null;
        break;
      case ViewStatus.LOADING:
        body = viewModel.viewState.value == null ? _buildLoadingState(viewModel, context) : UULOverlayLoadingIndicator(child: _buildIdleState(viewModel, context));
        break;
    }
    return body;
  }

  Widget _buildIdleState(TimeSlotsViewModel viewModel, BuildContext context) {
    TimeSlotsScreenObject screenObject = viewModel.viewState.value;
    return Column(
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

  Widget _buildLoadingState(TimeSlotsViewModel viewModel, BuildContext context) {
    return Container(
      child: Center(
        child: UULLoadingIndicator(),
      ),
    );
  }
}
