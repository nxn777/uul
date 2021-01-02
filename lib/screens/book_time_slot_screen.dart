import 'package:UUL_Gym/common/date_helpers.dart';
import 'package:UUL_Gym/constants/color_constants.dart';
import 'package:UUL_Gym/constants/dimens.dart';
import 'package:UUL_Gym/constants/text_style_constants.dart';
import 'package:UUL_Gym/models/app_state.dart';
import 'package:UUL_Gym/models/gym.dart';
import 'package:UUL_Gym/models/time_slot.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookTimeSlotScreen extends StatelessWidget {
  final TimeSlot timeSlot;

  BookTimeSlotScreen({this.timeSlot});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppState>(context, listen: false);
    final String gymTitle = state.activeGym.title;
    final placesLeft = state.rules.personsPerTimeSlot - timeSlot.occupiedBy.length;
    final placesLeftDesc = "Places left: $placesLeft";

    return Container(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(kSpacingMedium),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(kLargeBorderRadius),
            topRight: Radius.circular(kLargeBorderRadius),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: kSpacingSmall),
              child: Text(
                gymTitle,
                style: kCaptionInactiveTextStyle.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: kSpacingSmall),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Text(
                    DateHelpers.formatTimeSlotTitle(timeSlot),
                    style: kPageTitleTextStyle,
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    placesLeftDesc,
                    style: kCaptionInactiveTextStyle.copyWith(fontWeight: FontWeight.w900, color: kInactiveColor),
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
            ),
            Visibility(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, kSpacingSmall, 0, 0),
                child: Text(
                  "Also booked by:\n\n" + _countOccupiedByAppartment(),
                  style: kRegularActiveTextStyle.copyWith(fontWeight: FontWeight.w900, color: Colors.black),
                  textAlign: TextAlign.start,
                ),
              ),
              visible: timeSlot.occupiedBy.length > 0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: kSpacingSmall),
              child: FlatButton(
                onPressed: placesLeft == 0
                    ? null
                    : () {
                        Navigator.pop(context);
                      },
                height: kSpacingXXLarge,
                color: kAccentColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kMediumBorderRadius), side: BorderSide(color: placesLeft == 0 ? kInactiveColor : kAccentColor)),
                child: Text(
                  "Book",
                  style: kCaptionActiveTextStyle.copyWith(fontWeight: FontWeight.w900, color: placesLeft == 0 ? kInactiveColor : Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _countOccupiedByAppartment() {
    var map = Map<String, int>();
    timeSlot.occupiedBy.forEach((element) {
      var count = map.putIfAbsent(element.apartment.code, () => 0);
      count++;
      map[element.apartment.code] = count;
    });
    String result = "";
    map.entries.forEach((element) {
      result = result + element.key + " x " + element.value.toString() + "\n";
    });
    return result;
  }
}
