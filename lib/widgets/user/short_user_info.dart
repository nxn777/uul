import 'package:UUL_Gym/constants/dimens.dart';
import 'package:UUL_Gym/constants/text_style_constants.dart';
import 'package:flutter/material.dart';

class ShortUserInfo extends StatelessWidget {
  final String name;
  final String appartment;

  ShortUserInfo({this.name, this.appartment});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: name != null && name.isNotEmpty,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Username:",
                  style: kRegularActiveTextStyle,
                ),
                Text(
                  name != null ? name : "",
                  style: kRegularActiveTextStyle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(
                  height: kSpacingMedium,
                ),
              ],
            ),
          ),
          Visibility(
            visible: appartment != null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Appartment:",
                  style: kRegularActiveTextStyle,
                ),
                Text(
                  appartment != null ? appartment : "",
                  style: kRegularActiveTextStyle,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
