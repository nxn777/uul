import 'package:common/common.dart';
import 'package:flutter/material.dart';

class StepControls extends StatelessWidget {
  final String nextTitle;
  final String clearTitle;
  final VoidCallback onStepContinue;
  final VoidCallback onStepCancel;

  StepControls({this.onStepContinue, this.onStepCancel, this.nextTitle, this.clearTitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0, kSpacingMedium, kSpacingMedium, 0),
          child: FlatButton(
            onPressed: this.onStepContinue,
            height: kSpacingXLarge,
            color: kAccentColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kMediumBorderRadius), side: BorderSide(color: kAccentColor)),
            child: Text(
              nextTitle != null ? nextTitle : "Next",
              style: kRegularActiveTextStyle.copyWith(color: Colors.black),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, kSpacingMedium, kSpacingMedium, 0),
          child: FlatButton(
            onPressed: this.onStepCancel,
            height: kSpacingXLarge,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kMediumBorderRadius), side: BorderSide(color: kInactiveColor)),
            child: Text(
              clearTitle != null ? clearTitle : "Clear",
              style: kRegularActiveTextStyle.copyWith(color: kInactiveColor),
            ),
          ),
        ),
      ],
    );
  }
}
