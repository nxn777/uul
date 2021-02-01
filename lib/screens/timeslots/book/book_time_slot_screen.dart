import 'package:UUL_Gym/common/date_helpers.dart';
import 'package:UUL_Gym/constants/color_constants.dart';
import 'package:UUL_Gym/constants/dimens.dart';
import 'package:UUL_Gym/constants/text_style_constants.dart';
import 'package:UUL_Gym/models/time_slot.dart';
import 'package:flutter/material.dart';

class BookTimeSlotScreen extends StatelessWidget {
  final TimeSlot timeSlot;
  final String gymTitle;
  final int placesLeft;
  final placesLeftDesc;

  BookTimeSlotScreen({@required this.timeSlot, @required this.gymTitle, @required this.placesLeft}) : this.placesLeftDesc = "Places left: $placesLeft";

  @override
  Widget build(BuildContext context) {
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
                  "Also booked by:\n\n" + _countOccupiedByApartment(),
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

  String _countOccupiedByApartment() {
    var map = Map<String, int>();
    timeSlot.occupiedBy.forEach((element) {
      var count = map.putIfAbsent(element.apartmentCode, () => 0);
      count++;
      map[element.apartmentCode] = count;
    });
    String result = "";
    map.entries.forEach((element) {
      result = result + element.key + " x " + element.value.toString() + "\n";
    });
    return result;
  }
}
