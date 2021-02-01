import 'package:UUL_Gym/constants/color_constants.dart';
import 'package:UUL_Gym/constants/dimens.dart';
import 'package:UUL_Gym/constants/text_style_constants.dart';
import 'package:flutter/material.dart';

class UULButton extends StatelessWidget {
  final String title;
  final double width;
  final bool isActive;
  final bool isSolid;
  final void Function() onPressed;

  UULButton({@required this.title, this.width, this.isActive = true, this.isSolid = true, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return width == null
        ? _getButton()
        : SizedBox(
            width: width,
            child: _getButton(),
          );
  }

  Widget _getButton() {
    return FlatButton(
      onPressed: onPressed,
      height: kSpacingXXLarge,
      color: isSolid ? kAccentColor : Colors.transparent,
      shape: _getBorder(),
      child: Text(
        title,
        style: kCaptionActiveTextStyle.copyWith(fontWeight: FontWeight.w900, color: isActive ? Colors.black : kInactiveColor),
      ),
    );
  }

  ShapeBorder _getBorder() {
    if (isSolid) {
      return RoundedRectangleBorder(borderRadius: BorderRadius.circular(kMediumBorderRadius), side: BorderSide(color: isActive ? kAccentColor : kInactiveColor));
    } else {
      return RoundedRectangleBorder(borderRadius: BorderRadius.circular(kMediumBorderRadius), side: BorderSide(color: kInactiveColor));
    }
  }
}
