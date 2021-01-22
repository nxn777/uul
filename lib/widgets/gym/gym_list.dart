import 'package:UUL_Gym/models/gym.dart';
import 'package:UUL_Gym/widgets/selector/horizontal_selector.dart';
import 'package:flutter/material.dart';

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
