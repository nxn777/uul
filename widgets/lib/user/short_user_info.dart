import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';

class ShortUserInfo extends StatelessWidget {
  final String name;
  final String apartmentCode;
  final String login;

  ShortUserInfo({this.name, this.apartmentCode, this.login});

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
                  "Login:".i18n,
                  style: kRegularActiveTextStyle,
                ),
                Text(
                  login != null ? login : "",
                  style: kRegularActiveTextStyle.copyWith(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(
                  height: kSpacingSmall,
                ),
              ],
            ),
          ),
          Visibility(
            visible: name != null && name.isNotEmpty,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name:".i18n,
                  style: kRegularActiveTextStyle,
                ),
                Text(
                  name != null ? name : "",
                  style: kRegularActiveTextStyle.copyWith(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(
                  height: kSpacingSmall,
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
                  "Apartment:".i18n,
                  style: kRegularActiveTextStyle,
                ),
                Text(
                  apartmentCode != null ? apartmentCode : "",
                  style: kRegularActiveTextStyle.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
