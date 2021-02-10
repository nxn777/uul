import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InhabitantCard extends StatelessWidget {
  final Inhabitant inhabitant;
  final int activeInhabitantId;
  final void Function(Inhabitant) onTap;

  InhabitantCard(this.inhabitant, this.activeInhabitantId, {this.onTap});

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
              padding: const EdgeInsets.fromLTRB(kSpacingMedium, kSpacingLarge, kSpacingMedium, kSpacingLarge),
              child: FaIcon(
                _getActiveStatusIcon(),
                color: kAccentColor,
                size: kSpacingXLarge,
              ),
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
                    "inhabitant.apartmentCode",
                    style: kCaptionInactiveTextStyle.copyWith(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(kSpacingMedium),
              child:FaIcon(FontAwesomeIcons.checkCircle, color: kAccentColor),// _getActivatedStatusIcon(),
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

  // Widget _getActivatedStatusIcon() {
  //   if (user.isActivated) {
  //     return FaIcon(FontAwesomeIcons.checkCircle, color: kAccentColor);
  //   } else {
  //     return FaIcon(FontAwesomeIcons.clock, color: kInactiveColor);
  //   }
  // }
}
