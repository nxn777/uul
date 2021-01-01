import 'package:flutter/material.dart';
import 'package:UUL_Gym/constants/color_constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserProfilesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        child: FaIcon(
          FontAwesomeIcons.userPlus,
          color: Colors.black,
        ),
        backgroundColor: kAccentColor,
      ),
    );
  }
}
