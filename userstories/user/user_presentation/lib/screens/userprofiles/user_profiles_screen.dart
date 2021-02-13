import 'package:arch_components/arch_components.dart';
import 'package:common/common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:widgets/widgets.dart';

import 'user_profiles_screen_builder.dart';
import 'user_profiles_viewmodel.dart';

class UserProfilesScreen extends StatelessWidget with ViewStateScreen<UserProfilesViewModel> {
  final Future Function() onNewProfileTap;
  final Future Function() onNewInhabitantTap;
  final Future Function() onLoginTap;

  UserProfilesScreen({@required this.onNewProfileTap, @required this.onLoginTap, @required this.onNewInhabitantTap});

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
                      onPressed: () => _handleFABClick(viewModel),
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
      CurrentInhabitantCard(
        inhabitant: screenObject.currentInhabitant,
        isActive: screenObject.currentInhabitant.id == screenObject.activeInhabitantId,
        isProfileActivated: screenObject.user.isActivated,
        apartment: screenObject.user.apartmentCode,
        onMakeActiveTap: (item) => viewModel.changeActiveInhabitant(item),
      ),
      insideListView
          ? InhabitantList(
              insideListView: true,
              inhabitants: screenObject.notCurrentInhabitants,
              activeInhabitantId: screenObject.activeInhabitantId,
              onInhabitantTap: (item) => viewModel.changeCurrentInhabitant(item),
              onMakeInhabitantActiveTap: (item) => viewModel.changeActiveInhabitant(item),
            )
          : Expanded(
              child: InhabitantList(
                insideListView: false,
                inhabitants: screenObject.notCurrentInhabitants,
                activeInhabitantId: screenObject.activeInhabitantId,
                onInhabitantTap: (item) => viewModel.changeCurrentInhabitant(item),
                onMakeInhabitantActiveTap: (item) => viewModel.changeActiveInhabitant(item),
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

  void _handleFABClick(UserProfilesViewModel viewModel) async {
    var so = viewModel.viewState.value;
    if (so == null && viewModel.viewState.status == ViewStatus.IDLE) {
      var result = await this.onNewProfileTap();
      viewModel.onUserActionResult(result);
      return;
    }
    if ((so != null && so.canAddMore)) {
      var result = await this.onNewInhabitantTap();
      viewModel.onUserActionResult(result);
      return;
    }
  }
}
