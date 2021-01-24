import 'package:UUL_Gym/common/base_view_state.dart';
import 'package:UUL_Gym/constants/color_constants.dart';
import 'package:UUL_Gym/constants/dimens.dart';
import 'package:UUL_Gym/constants/text_style_constants.dart';
import 'package:UUL_Gym/screens/userprofiles/user_profiles_screen_builder.dart';
import 'package:UUL_Gym/screens/userprofiles/user_profiles_viewmodel.dart';
import 'package:UUL_Gym/widgets/avatars/bundled_avatar.dart';
import 'package:UUL_Gym/widgets/button/u_u_l_button.dart';
import 'package:UUL_Gym/widgets/title/screen_title.dart';
import 'package:UUL_Gym/widgets/user/current_user_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class UserProfilesScreen extends StatelessWidget with ViewStateScreen<UserProfilesViewModel> {
  final Function onNewProfileTap;
  final Future Function() onLoginTap;

  UserProfilesScreen({@required this.onNewProfileTap, @required this.onLoginTap});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserProfilesViewModel>(
      create: (context) => UserProfilesScreenBuilder.buildAndStartVM(context),
      child: Consumer<UserProfilesViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            body: SafeArea(
              child: buildBody(viewModel, context),
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

  @override
  Widget buildIdleState(UserProfilesViewModel viewModel, BuildContext context) {
    var screenObject = viewModel.viewState.value;
    if (screenObject == null) {
      return buildNoProfilesState();
    }
    return Column(
      children: [
        CurrentUserCard(
          user: screenObject.currentUser,
          isActive: screenObject.currentUser.id == screenObject.activeUserId,
        ),
      ],
    );
  }

  Widget buildNoProfilesState() {
    return ListView(
      children: [
        ScreenTitle("User profile"),
        Center(
          child: BundledAvatar(height: kSpacingHuge * 2, imageSrc: "assets/defaults/default_user3.png"),
        ),
        Padding(
          padding: const EdgeInsets.all(kSpacingMedium),
          child: Text(
            "There are no stored user profiles",
            style: kRegularActiveTextStyle,
            textAlign: TextAlign.center,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            UULButton(
              title: "Log in",
              width: kSpacingHuge * 2,
              onPressed: () async {
                var result = await this.onLoginTap();
                print(result);
              },
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(kSpacingMedium),
          child: Text(
            "Or create a new profile",
            style: kRegularActiveTextStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
