import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';

class BookTimeSlotScreen extends StatelessWidget {
  final bool isLoggedIn;
  final TimeSlot timeSlot;
  final String gymTitle;
  final int placesLeft;
  final placesLeftDesc;
  final void Function(TimeSlot) onBookTap;
  BookTimeSlotScreen({@required this.timeSlot, @required this.gymTitle, @required this.placesLeft, @required this.onBookTap, @required this.isLoggedIn})
      : this.placesLeftDesc = "Places left: %s".i18n.fill([placesLeft]);

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
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    DateFormatter.formatTimeSlotTitle(timeSlot.start, timeSlot.end),
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
                  "Also booked by:\n\n%s".i18n.fill([_countOccupiedByApartment()]),
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
                        onBookTap.call(timeSlot);
                        Navigator.pop(context);
                      },
                height: kSpacingXXLarge,
                color: kAccentColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kMediumBorderRadius), side: BorderSide(color: placesLeft == 0 ? kInactiveColor : kAccentColor)),
                child: Text(
                  isLoggedIn ? "Book".i18n : "To book, please log in".i18n,
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
