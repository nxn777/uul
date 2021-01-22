import 'package:UUL_Gym/constants/color_constants.dart';
import 'package:UUL_Gym/constants/dimens.dart';
import 'package:UUL_Gym/screens/userprofiles/user_profiles_viewmodel.dart';
import 'package:UUL_Gym/widgets/user/current_user_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class UserProfilesScreen extends StatelessWidget {
  final Function onNewProfileTap;

  UserProfilesScreen({@required this.onNewProfileTap});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserProfilesViewModel>(
      create: (context) => UserProfilesViewModel(),
      child: Consumer<UserProfilesViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [CurrentUserCard(user: viewModel.activeUser)],
              ),
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
        },
      ),
    );
  }
}
