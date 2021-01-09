import 'package:UUL_Gym/constants/color_constants.dart';
import 'package:UUL_Gym/constants/dimens.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserProfilesScreen extends StatelessWidget {
  final Function onNewProfileTap;

  UserProfilesScreen({@required this.onNewProfileTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, kSpacingHuge),
        child: FloatingActionButton(
          elevation: kSpacingXXSmall,
          onPressed: () {
            this.onNewProfileTap();
          },
          child: FaIcon(
            FontAwesomeIcons.userPlus,
            color: Colors.black,
          ),
          backgroundColor: kAccentColor,
        ),
      ),
    );
  }
}
