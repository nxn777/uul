import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:widgets/avatars/bundled_avatar.dart';
import 'package:widgets/button/u_u_l_icon_button.dart';

class InhabitantCard extends StatelessWidget {
  final Inhabitant inhabitant;
  final int activeInhabitantId;
  final void Function(Inhabitant) onTap;
  final void Function(Inhabitant) onMakeActiveTap;

  InhabitantCard(this.inhabitant, this.activeInhabitantId, {this.onTap, this.onMakeActiveTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(kSpacingMedium, kSpacingXSmallPlus, kSpacingMedium, kSpacingXSmallPlus),
      child: InkWell(
        onTap: () {
          this.onTap?.call(inhabitant);
        },
        borderRadius: BorderRadius.circular(kDefaultBorderRadius),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding:  const EdgeInsets.fromLTRB(kSpacingMedium, kSpacingLarge, kSpacingMedium, kSpacingLarge),
              child: BundledAvatar(imageSrc: inhabitant.avatarSrc, height: kSpacingHuge,),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, kSpacingSmall),
                    child: Text(
                      inhabitant.name,
                      style: kCaptionActiveTextStyle.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    inhabitant.getLastVisitFormatted(),
                    style: kCaptionInactiveTextStyle.copyWith(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(kSpacingMedium, kSpacingLarge, kSpacingMedium, kSpacingLarge),
              child: UULIconButton(
                backgroundColor: Colors.transparent,
                innerBackgroundColor: Colors.transparent,
                icon: _getActiveStatusIcon(),
                onTap: () {
                  if (inhabitant.id != activeInhabitantId) {
                    this.onMakeActiveTap?.call(inhabitant);
                  }
                },
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(color: kBackgroundColor, borderRadius: BorderRadius.circular(kDefaultBorderRadius)),
    );
  }

  IconData _getActiveStatusIcon() {
    if (inhabitant.id == activeInhabitantId) {
      return FontAwesomeIcons.solidStar;
    } else {
      return FontAwesomeIcons.star;
    }
  }
}
