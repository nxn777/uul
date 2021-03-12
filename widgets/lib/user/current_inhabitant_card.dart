import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:super_tooltip/super_tooltip.dart';
import 'package:widgets/avatars/bundled_avatar.dart';
import 'package:widgets/button/u_u_l_icon_button.dart';
import 'package:widgets/title/screen_title.dart';
import 'package:i18n/i18n.dart';

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
        color: Colors.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: ScreenTitle("User profile".i18n)),
              UULIconButton(
                backgroundColor: Colors.transparent,
                innerBackgroundColor: Colors.transparent,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kSpacingXLarge),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 52,
                ),
                BundledAvatar(
                  height: kSpacingHuge * 2,
                  imageSrc: inhabitant?.avatarSrc == null ? "assets/defaults/default_user3.png" : inhabitant.avatarSrc,
                  borderColor: isProfileActivated ? kAccentColor : kInactiveColor,
                  onTap: (_) => showToolTip(context),
                ),
                UULIconButton(
                  icon: FontAwesomeIcons.pen,
                  backgroundColor: Colors.transparent,
                  innerBackgroundColor: Colors.transparent,
                  innerPadding: 12,
                  onTap: () {
                    this.onEditTap?.call();
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kSpacingXLarge),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  width: 52,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(kSpacingMedium),
                      child: Text(
                        inhabitant.name,
                        style: kCaptionActiveTextStyle.copyWith(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(kSpacingMedium, 0, kSpacingMedium, kSpacingMedium),
                      child: Container(
                        width: kSpacingXLarge*5,
                        child: Text(
                          "Apartment: %s\n%s".i18n.fill([apartment, inhabitant.getLastVisitFormatted()]),
                          style: kRegularInactiveTextStyle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                isSingle
                    ? SizedBox(
                        width: 52,
                      )
                    : Padding(
                        padding: EdgeInsets.fromLTRB(0, kSpacingMedium, 0, 0),
                        child: UULIconButton(
                          backgroundColor: Colors.transparent,
                          innerBackgroundColor: Colors.transparent,
                          icon: isActive ? FontAwesomeIcons.solidStar : FontAwesomeIcons.star,
                          onTap: () {
                            if (!isActive) {
                              this.onMakeActiveTap?.call(inhabitant);
                            }
                          },
                        ),
                      ),
              ],
            ),
          ),
        ],
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
              ? "This profile is activated.\nYou can use it to book gyms".i18n
              : "This profile is not activated.\nTo activate you should visit\nUNO URBAN Life\nadministration in person."
                  .i18n,
          softWrap: true,
          style: kRegularActiveTextStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );

    tooltip.show(context);
  }
}
