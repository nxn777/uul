import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UULIconButton extends StatelessWidget {
  final void Function() onTap;
  final IconData icon;

  final Color color;
  final Color backgroundColor;
  final Color innerBackgroundColor;
  final double side;
  final double innerPadding;

  UULIconButton({this.icon, this.onTap, Color color, Color backgroundColor, innerBackgroundColor, double side, double innerPadding})
      : color = color == null ? kAccentColor : color,
        backgroundColor = backgroundColor == null ? Colors.black12.withOpacity(0.05) : backgroundColor,
        innerBackgroundColor = innerBackgroundColor == null ? Colors.white : innerBackgroundColor,
        side = side == null ? kSpacingXXLarge : side,
        innerPadding = innerPadding == null ? kSpacingSmall : innerPadding;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(kDefaultBorderRadius),
      child: Material(
        color: backgroundColor,
        child: InkWell(
          onTap: this.onTap,
          child: Padding(
            padding: const EdgeInsets.all(kSpacingXXSmall),
            child: Container(
              height: side,
              width: side,
              //color: Colors.white,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(kDefaultBorderRadius - kSpacingXXSmall), color: innerBackgroundColor),
              child: Center(
                child: FaIcon(
                  this.icon,
                  color: this.color,
                  size: side - innerPadding * 2,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
