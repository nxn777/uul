import 'package:UUL_Gym/constants/dimens.dart';
import 'package:flutter/material.dart';

class BundledAvatar extends StatelessWidget {
  final void Function(String) onTap;
  final String imageSrc;
  final double height;
  final Color borderColor;
  BundledAvatar({this.onTap, this.imageSrc, this.height, this.borderColor});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height),
      child: Material(
        color: this.borderColor,
        child: InkWell(
          onTap: () {
            this.onTap?.call(imageSrc);
          },
          child: Padding(
            padding: const EdgeInsets.all(kSpacingXSmall),
            child: CircleAvatar(
              radius: (height - 2 * kSpacingXSmall) / 2,
              backgroundImage: AssetImage(
                imageSrc != null ? imageSrc : "assets/defaults/default_user3.png",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
