import 'package:common/common.dart';
import 'package:flutter/material.dart';

class ShortUserInfo extends StatelessWidget {
  final String name;
  final String apartmentCode;

  ShortUserInfo({this.name, this.apartmentCode});

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
            visible: apartmentCode != null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Apartment:",
                  style: kRegularActiveTextStyle,
                ),
                Text(
                  apartmentCode != null ? apartmentCode : "",
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
