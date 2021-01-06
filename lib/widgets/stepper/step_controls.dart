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
        FlatButton.icon(
          label: Text("Next"),
          icon: FaIcon(FontAwesomeIcons.checkCircle),
          onPressed: onStepContinue,
          //child: const Text('NEXT'),
        ),
        TextButton(
          onPressed: onStepCancel,
          child: const Text('CANCEL'),
        ),
      ],
    );
  }
}

Widget stepControlsBuilder(_, {VoidCallback onStepContinue, VoidCallback onStepCancel}) => StepControls(onStepContinue, onStepCancel);