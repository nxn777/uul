import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:i18n/i18n.dart';

class TimeSlotTile extends StatelessWidget {
  final TimeSlot timeSlot;
  final bool isCurrentDay;
  final Rules rules;
  final Function(TimeSlot) onTap;

  TimeSlotTile({@required this.timeSlot, @required this.isCurrentDay, @required this.rules, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(kSpacingMedium, kSpacingXSmallPlus, kSpacingMedium, kSpacingXSmallPlus),
      child: InkWell(
        onTap: () {
          if (isCurrentDay) {
            this.onTap(this.timeSlot);
          }
        },
        borderRadius: BorderRadius.circular(kDefaultBorderRadius),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(kSpacingMedium, kSpacingLarge, kSpacingMedium, kSpacingLarge),
              child: FaIcon(
                _getIcon(),
                color: _getIconColor(),
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
                      DateFormatter.formatTimeSlotTitle(timeSlot.start, timeSlot.end),
                      style: kCaptionActiveTextStyle.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    _getTimeSlotOccupiedByDescription(),
                    style: kCaptionInactiveTextStyle.copyWith(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(kSpacingMedium),
              child: FaIcon(
                FontAwesomeIcons.angleRight,
                color: kSecondaryColor,
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(color: kBackgroundColor, borderRadius: BorderRadius.circular(kDefaultBorderRadius)),
    );
  }

  String _getTimeSlotOccupiedByDescription() {
    if (timeSlot.occupiedBy.isEmpty) {
      String result = "All %s places are available".i18n.fill([rules.personsPerTimeSlot]);
      if (rules.personsPerTimeSlot == 1) {
        result = "The only place is available".i18n;
      }
      return result;
    } else {
      var left = rules.personsPerTimeSlot - timeSlot.occupiedBy.length;
      return "%d places left".i18n.plural(left);
    }
  }

  IconData _getIcon() {
    IconData icon;
    if (timeSlot.occupiedBy.isEmpty || timeSlot.occupiedBy.length == rules.personsPerTimeSlot) {
      icon = FontAwesomeIcons.solidStar;
    } else {
      icon = FontAwesomeIcons.starHalfAlt;
    }
    return icon;
  }

  Color _getIconColor() {
    var color = isCurrentDay ? kAccentColor : kInactiveColor;
    if (timeSlot.occupiedBy.length == rules.personsPerTimeSlot) {
      color = kInactiveColor;
    }
    return color;
  }
}
