import 'package:UUL_Gym/constants/dimens.dart';
import 'package:UUL_Gym/constants/text_style_constants.dart';
import 'package:UUL_Gym/models/user.dart';
import 'package:UUL_Gym/widgets/avatars/bundled_avatar.dart';
import 'package:UUL_Gym/widgets/button/u_u_l_icon_button.dart';
import 'package:UUL_Gym/widgets/title/screen_title.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CurrentUserCard extends StatelessWidget {
  final User user;
  final bool isActive;

  CurrentUserCard({@required this.user, @required this.isActive});

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
                  onTap: () {},
                ),
                BundledAvatar(
                  height: kSpacingHuge * 2,
                  imageSrc: user?.avatarImageSrc == null ? "assets/defaults/default_user3.png" : user.avatarImageSrc,
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
                      user.apartment.code,
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
}
