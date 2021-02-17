import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:super_tooltip/super_tooltip.dart';
import 'package:widgets/avatars/bundled_avatar.dart';
import 'package:widgets/button/u_u_l_icon_button.dart';
import 'package:widgets/title/screen_title.dart';

class CurrentInhabitantCard extends StatelessWidget {
  final Inhabitant inhabitant;
  final bool isActive;
  final bool isProfileActivated;
  final String apartment;
  final bool isSingle;
  final void Function(Inhabitant) onMakeActiveTap;
  final void Function() onEditTap;
  final void Function() onEditProfileTap;

  CurrentInhabitantCard(
      {@required this.inhabitant,
      @required this.isActive,
      @required this.isSingle,
      this.isProfileActivated,
      this.apartment,
      this.onMakeActiveTap,
      this.onEditTap,
      this.onEditProfileTap});

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
            Row(
              children: [
                Expanded(child: ScreenTitle("User profile")),
                UULIconButton(
                  icon: FontAwesomeIcons.cog,
                  onTap: () {
                    this.onEditProfileTap();
                  },
                ),
                SizedBox(
                  width: kSpacingXLarge,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                isSingle
                    ? SizedBox(
                        width: 52,
                      )
                    : UULIconButton(
                        icon: isActive ? FontAwesomeIcons.solidStar : FontAwesomeIcons.star,
                        onTap: () {
                          if (!isActive) {
                            this.onMakeActiveTap?.call(inhabitant);
                          }
                        },
                      ),
                BundledAvatar(
                  height: kSpacingHuge * 2,
                  imageSrc: inhabitant?.avatarSrc == null ? "assets/defaults/default_user3.png" : inhabitant.avatarSrc,
                  borderColor: isProfileActivated ? kAccentColor : kInactiveColor,
                  onTap: (_) => showToolTip(context),
                ),
                UULIconButton(
                  icon: FontAwesomeIcons.pen,
                  innerPadding: 12,
                  onTap: () {
                    this.onEditTap?.call();
                  },
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
                      inhabitant.name,
                      style: kCaptionActiveTextStyle.copyWith(fontWeight: FontWeight.bold),
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
                      "Apartment: $apartment\n${inhabitant.getLastVisitFormatted()}",
                      style: kRegularInactiveTextStyle,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
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
      borderColor: isProfileActivated ? kAccentColor : kInactiveColor,
      content: new Material(
        child: Text(
          isProfileActivated
              ? "This profile is activated.\nYou can use it to book gyms"
              : "This profile is not activated.\nTo activate you should visit\nUNO URBAN Life\nadministration in person.",
          softWrap: true,
          style: kRegularActiveTextStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );

    tooltip.show(context);
  }
}
