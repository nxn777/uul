import 'dart:ui';

import 'package:arch_components/arch_components.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:widgets/widgets.dart';

import 'book/book_time_slot_screen.dart';
import 'time_slot_screen_builder.dart';
import 'time_slots_screen_object.dart';
import 'time_slots_viewmodel.dart';

class TimeSlotScreen extends StatelessWidget with ViewStateScreen<TimeSlotsViewModel> {
  @override
  TimeSlotsViewModel Function(BuildContext p1) vmCreator()  => TimeSlotsScreenBuilder.buildAndStartVM;

  Widget buildIdleState(TimeSlotsViewModel viewModel, BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _getScreenChildren(context, viewModel, false),
        );
      } else {
        return ListView(
          children: _getScreenChildren(context, viewModel, true),
        );
      }
    });
  }

  List<Widget> _getScreenChildren(BuildContext context, TimeSlotsViewModel viewModel, bool insideListView) {
    TimeSlotsScreenObject screenObject = viewModel.viewState.value;
    return [
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
      _getScheduleContent(context, insideListView, viewModel)
    ];
  }

  Widget _getScheduleContent(BuildContext context, bool insideListView, TimeSlotsViewModel viewModel) {
    TimeSlotsScreenObject screenObject = viewModel.viewState.value;
    if (screenObject.timeSlots.isNotEmpty || viewModel.viewState.status == ViewStatus.LOADING) {
      return Expanded(
        child: TimeSlotList(
          insideListView: insideListView,
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
                      isLoggedIn: viewModel.isLoggedIn(),
                      timeSlot: timeSlot,
                      gymTitle: screenObject.activeGym.getTitle(),
                      placesLeft: screenObject.rules.personsPerTimeSlot - timeSlot.occupiedBy.length,
                      onBookTap: viewModel.bookTimeSlot,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
    if(screenObject.currentDate.isBefore(screenObject.activeDate)) {
      return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(FontAwesomeIcons.earlybirds, size: kSpacingXLarge, color: kAccentColor,),
            SizedBox(height: kSpacingMedium,),
            Text("Gym booking is not available for this day yet", style: kRegularActiveTextStyle,),
          ],
        ),
      );//
    } else {
      return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(FontAwesomeIcons.question, size: kSpacingXLarge, color: kAccentColor,),
            SizedBox(height: kSpacingMedium,),
            Text("No data for this day", style: kRegularActiveTextStyle,),
          ],
        ),
      );//
    }
  }
}
