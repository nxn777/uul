import 'package:UUL_Gym/common/base_view_state.dart';
import 'package:common/common.dart';
import 'package:UUL_Gym/screens/userprofiles/user_profiles_screen_builder.dart';
import 'package:UUL_Gym/screens/userprofiles/user_profiles_viewmodel.dart';
import 'package:widgets/widgets.dart';
import 'package:UUL_Gym/widgets/button/u_u_l_button.dart';
import 'package:UUL_Gym/widgets/title/screen_title.dart';
import 'package:UUL_Gym/widgets/user/current_user_card.dart';
import 'package:UUL_Gym/widgets/user/user_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class UserProfilesScreen extends StatelessWidget with ViewStateScreen<UserProfilesViewModel> {
  final Future Function() onNewProfileTap;
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
            floatingActionButton: shouldShowFAB(viewModel)
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, kSpacingHuge),
                    child: FloatingActionButton(
                      elevation: kSpacingXXSmall,
                      onPressed: () async {
                        var result = await this.onNewProfileTap();
                        viewModel.onUserActionResult(result);
                      },
                      child: FaIcon(
                        FontAwesomeIcons.userPlus,
                        color: Colors.black,
                      ),
                      backgroundColor: kAccentColor,
                    ),
                  )
                : null,
          );
        },
      ),
    );
  }

  @override
  Widget buildIdleState(UserProfilesViewModel viewModel, BuildContext context) {
    var screenObject = viewModel.viewState.value;
    if (screenObject == null) {
      return buildNoProfilesState(viewModel);
    }
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) {
        return Column(
          children: getScreenWidgets(viewModel, false),
        );
      } else {
        return ListView(
          children: getScreenWidgets(viewModel, true),
        );
      }
    });
  }

  List<Widget> getScreenWidgets(UserProfilesViewModel viewModel, bool insideListView) {
    var screenObject = viewModel.viewState.value;
    return [
      CurrentUserCard(
        user: screenObject.currentUser,
        isActive: screenObject.currentUser?.id == screenObject.activeUserId,
        onMakeActiveTap: (user) => viewModel.changeActiveUser(user),
      ),
      insideListView
          ? UserList(
              insideListView: true,
              users: screenObject.notCurrentUsers,
              activeUserId: screenObject.activeUserId,
              onUserTap: (user) => viewModel.changeCurrentUser(user),
            )
          : Expanded(
              child: UserList(
                insideListView: false,
                users: screenObject.notCurrentUsers,
                activeUserId: screenObject.activeUserId,
                onUserTap: (user) => viewModel.changeCurrentUser(user),
              ),
            )
    ];
  }

  Widget buildNoProfilesState(UserProfilesViewModel viewModel) {
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
                bool result = await this.onLoginTap();
                viewModel.onUserActionResult(result);
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

  bool shouldShowFAB(UserProfilesViewModel viewModel) {
    var so = viewModel.viewState.value;
    return (so == null && viewModel.viewState.status == ViewStatus.IDLE) || (so != null && so.canAddMore);
  }
}
