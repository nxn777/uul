import 'package:UUL_Gym/widgets/gym/gym_tile.dart';
import 'package:flutter/material.dart';
import 'package:UUL_Gym/models/gym.dart';

class GymList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _getGymTiles(),
    );
  }

  List<Widget> _getGymTiles() => Gym.values.map((g) => GymTile(gym: g)).toList();
}
