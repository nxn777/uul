import 'package:UUL_Gym/common/date_helpers.dart';
import 'package:UUL_Gym/constants/dimens.dart';
import 'package:UUL_Gym/constants/color_constants.dart';
import 'package:UUL_Gym/constants/text_style_constants.dart';
import 'package:UUL_Gym/models/rules.dart';
import 'package:UUL_Gym/models/time_slot.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                      DateHelpers.formatTimeSlotTitle(timeSlot),
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
      String result = "All ${rules.personsPerTimeSlot} places are available";
      if (rules.personsPerTimeSlot == 1) {
        result = "The only place is available";
      }
      return result;
    } else {
      String result;
      var left = rules.personsPerTimeSlot - timeSlot.occupiedBy.length;
      if (left > 1) {
        result = "$left places left";
      } else if (left == 1) {
        result = "1 place left";
      } else {
        result = "No places left";
      }
      return result;
    }
  }

  IconData _getIcon() {
    IconData icon;
    if (timeSlot.occupiedBy.isEmpty || timeSlot.occupiedBy.length == rules.personsPerTimeSlot) {
      icon = FontAwesomeIcons.solidStar;
    } else  {
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
