import 'package:UUL_Gym/constants/color_constants.dart';
import 'package:UUL_Gym/constants/dimens.dart';
import 'package:UUL_Gym/constants/text_style_constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StepControls extends StatelessWidget {
  final VoidCallback onStepContinue;
  final VoidCallback onStepCancel;

  StepControls(this.onStepContinue, this.onStepCancel);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: FlatButton(
            onPressed: this.onStepContinue,
            height: kSpacingXLarge,
            color: kAccentColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kMediumBorderRadius), side: BorderSide(color: kAccentColor)),
            child: Text(
              "Next",
              style:  kRegularActiveTextStyle.copyWith(color: Colors.black),
            ),
          ),
        ),
        FlatButton(
          onPressed: this.onStepCancel,
          height: kSpacingXLarge,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kMediumBorderRadius), side: BorderSide(color: kInactiveColor)),
          child: Text(
            "Clear",
            style: kRegularActiveTextStyle.copyWith(color: kInactiveColor),
          ),
        ),
      ],
    );
  }
}

Widget stepControlsBuilder(_, {VoidCallback onStepContinue, VoidCallback onStepCancel}) => StepControls(onStepContinue, onStepCancel);