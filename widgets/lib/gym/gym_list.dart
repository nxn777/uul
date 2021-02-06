import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:widgets/selector/horizontal_selector.dart';

class GymList extends StatelessWidget {
  final List<Gym> gyms;
  final void Function(Gym) onGymTapped;
  final bool Function(Gym) gymSelectedChecker;

  GymList({@required this.gyms, @required this.onGymTapped, @required this.gymSelectedChecker});

  @override
  Widget build(BuildContext context) {
    return HorizontalSelector<Gym>(
      items: gyms,
      onItemTap: onGymTapped,
      isItemSelected: gymSelectedChecker,
      textScale: 2,
      indicatorScale: 1.2,
    );
  }
}
