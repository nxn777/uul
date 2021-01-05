import 'package:UUL_Gym/constants/dimens.dart';
import 'package:UUL_Gym/constants/text_style_constants.dart';
import 'package:flutter/material.dart';

class AddNewProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(kSpacingMedium, kSpacingLarge, kSpacingMedium, kSpacingLarge),
              child: Text(
                "New profile",
                style: kPageTitleTextStyle,
              ),
            ),
            Expanded(
              child: ListView(
                children: [Stepper(
                  physics: ScrollPhysics(),
                  steps: [
                    Step(
                      title: Text("Start"),
                      content: Text("Before starting, we should create a page."),
                    ),
                    Step(
                      title: Text("Constructor"),
                      content: Text("Let's look at its construtor."),
                    ),
                    Step(
                      title: Text("Start"),
                      content: Text("Before starting, we should create a page."),
                    ),
                    Step(
                      title: Text("Start"),
                      content: Text("Before starting, we should create a page."),
                    ),
                    Step(
                      title: Text("Start"),
                      content: Text("Before starting, we should create a page."),
                    ),
                    Step(
                      title: Text("Start"),
                      content: Text("Before starting, we should create a page."),
                    ),
                    Step(
                      title: Text("Start"),
                      content: Text("Before starting, we should create a page."),
                    ),
                    Step(
                      title: Text("Start"),
                      content: Text("Before starting, we should create a page."),
                    ),
                    Step(
                      title: Text("Start"),
                      content: Text("Before starting, we should create a page."),
                    ),
                    Step(
                      title: Text("Start"),
                      content: Text("Before starting, we should create a page."),
                    ),
                    Step(
                      title: Text("Start"),
                      content: Text("Before starting, we should create a page."),
                    ),
                    Step(
                      title: Text("end"),
                      content: Text("Before starting, we should create a page."),
                    ),
                  ],
                ),]
              ),
            )
          ],
        ),
      ),
    );
  }
}
