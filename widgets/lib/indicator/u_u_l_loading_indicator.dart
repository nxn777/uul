import 'package:common/common.dart';
import 'package:flutter/material.dart';

class UULLoadingIndicator extends StatefulWidget {
  @override
  _UULLoadingIndicatorState createState() => _UULLoadingIndicatorState();
}

class _UULLoadingIndicatorState extends State<UULLoadingIndicator> with TickerProviderStateMixin {
  AnimationController _resizableController;

  static Color colorVariation(double note) => kAccentColor.withOpacity(note);

  AnimatedBuilder getContainer() {
    return new AnimatedBuilder(
      animation: _resizableController,
      builder: (context, child) {
        return Container(
          width: kSpacingHuge,
          height: kSpacingHuge * 2,
          padding: EdgeInsets.all(kDefaultBorderRadius),
          child: Image.asset("assets/common/uul_logo.png"),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(kDefaultBorderRadius)),
              border: Border.all(color: colorVariation(_resizableController.value)),
              color: Colors.white),
        );
      },
    );
  }

  @override
  void initState() {
    _resizableController = new AnimationController(
      vsync: this,
      duration: new Duration(
        milliseconds: 300,
      ),
    );
    _resizableController.addStatusListener((animationStatus) {
      switch (animationStatus) {
        case AnimationStatus.completed:
          _resizableController.reverse();
          break;
        case AnimationStatus.dismissed:
          _resizableController.forward();
          break;
        case AnimationStatus.forward:
          break;
        case AnimationStatus.reverse:
          break;
      }
    });
    _resizableController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _resizableController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: getContainer());
  }
}
