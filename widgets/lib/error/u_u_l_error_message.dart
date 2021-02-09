import 'package:flutter/material.dart';
import 'package:common/common.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:widgets/widgets.dart';

class UULErrorMessage extends StatefulWidget {
  final void Function() onCancelTap;
  final void Function() onRetryTap;
  final bool canCancel;

  UULErrorMessage({this.onCancelTap, this.onRetryTap, this.canCancel = false});

  @override
  _UULErrorMessageState createState() => _UULErrorMessageState();
}

class _UULErrorMessageState extends State<UULErrorMessage> with TickerProviderStateMixin {
  AnimationController _resizableController;

  static Color colorVariation(double note) => Colors.black38.withRed((note * 255).floor());

  AnimatedBuilder getContainer() {
    return new AnimatedBuilder(
      animation: _resizableController,
      builder: (context, child) {
        return Container(
          padding: EdgeInsets.all(kDefaultBorderRadius),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: kSpacingXSmall,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kSpacingSmall),
                    child: Text(
                      _getMessage(),
                      style: kCaptionActiveTextStyle.copyWith(fontWeight: FontWeight.bold,),
                    ),
                  ),
                  SizedBox(
                    height: kSpacingXSmall,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: _getButtons(),
                  )
                ],
              ),
            ],
          ),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(kDefaultBorderRadius)),
              color: kAccentColor,
              boxShadow: [BoxShadow(color: colorVariation(_resizableController.value), offset: Offset.zero, spreadRadius: 1)]),
        );
      },
    );
  }

  @override
  void initState() {
    _resizableController = new AnimationController(
      vsync: this,
      duration: new Duration(
        milliseconds: 600,
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

  String _getMessage() {
    if (widget.canCancel) {
      return "Something went wrong";
    } else {
      return "Something\nwent wrong";
    }
  }

  List<Widget> _getButtons() {
    if (widget.canCancel) {
      return [
        UULIconButton(
          icon: FontAwesomeIcons.solidWindowClose,
          color: Colors.black12,
          innerBackgroundColor: kAccentColor,
          backgroundColor: kAccentColor,
          side: kSpacingHuge,
          innerPadding: kSpacingMedium,
          onTap: () {},
        ),
        SizedBox(
          width: kSpacingLarge,
        ),
        UULIconButton(
          icon: FontAwesomeIcons.redo,
          color: Colors.black,
          innerBackgroundColor: kAccentColor,
          backgroundColor: kAccentColor,
          side: kSpacingHuge,
          innerPadding: kSpacingMedium * (1 + _resizableController.value / 80),
          onTap: () {},
        )
      ];
    } else {
      return [
        UULIconButton(
          icon: FontAwesomeIcons.redo,
          color: Colors.black,
          innerBackgroundColor: kAccentColor,
          backgroundColor: kAccentColor,
          side: kSpacingHuge,
          innerPadding: kSpacingMedium * (1 + _resizableController.value / 80),
          onTap: () {},
        )
      ];
    }
  }
}
