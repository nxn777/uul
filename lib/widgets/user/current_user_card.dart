import 'package:common/common.dart';
import 'package:UUL_Gym/models/user.dart';
import 'package:UUL_Gym/widgets/avatars/bundled_avatar.dart';
import 'package:UUL_Gym/widgets/button/u_u_l_icon_button.dart';
import 'package:UUL_Gym/widgets/title/screen_title.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:super_tooltip/super_tooltip.dart';

class CurrentUserCard extends StatelessWidget {
  final User user;
  final bool isActive;
  final void Function(User) onMakeActiveTap;

  CurrentUserCard({@required this.user, @required this.isActive, this.onMakeActiveTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(kLargeBorderRadius),
          bottomLeft: Radius.circular(kLargeBorderRadius),
        ),
        color: Colors.white,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(kLargeBorderRadius),
          bottomRight: Radius.circular(kLargeBorderRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScreenTitle("User profile"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                UULIconButton(
                  icon: isActive ? FontAwesomeIcons.solidStar : FontAwesomeIcons.star,
                  onTap: () {
                    if (!isActive) {
                      this.onMakeActiveTap?.call(user);
                    }
                  },
                ),
                BundledAvatar(
                  height: kSpacingHuge * 2,
                  imageSrc: user?.avatarImageSrc == null ? "assets/defaults/default_user3.png" : user.avatarImageSrc,
                  borderColor: user.isActivated ? kAccentColor : kInactiveColor,
                  onTap: (_) => showToolTip(context),
                ),
                UULIconButton(
                  icon: FontAwesomeIcons.pen,
                  innerPadding: 12,
                  onTap: () {},
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(kSpacingMedium),
                    child: Text(
                      user.name,
                      style: kCaptionActiveTextStyle,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(kSpacingMedium, 0, kSpacingMedium, kSpacingMedium),
                    child: Text(
                      user.apartmentCode,
                      style: kRegularInactiveTextStyle,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showToolTip(BuildContext context) {
    var tooltip = SuperTooltip(
      hasShadow: false,
      borderWidth: 1,
      borderRadius: kDefaultBorderRadius,
      popupDirection: TooltipDirection.down,
      borderColor: user.isActivated ? kAccentColor : kInactiveColor,
      content: new Material(
          child: Text(
        user.isActivated
            ? "This profile is activated.\nYou can use it to book gyms"
            : "This profile is not activated.\nTo activate you should visit\nUNO URBAN Life\nadministration in person.",
        softWrap: true,
        style: kRegularActiveTextStyle,
        textAlign: TextAlign.center,
      )),
    );

    tooltip.show(context);
  }
}
