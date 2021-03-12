import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:common/common.dart';

class RoundedCurtain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(kLargeBorderRadius),
          bottomRight: Radius.circular(kLargeBorderRadius),
        ),
      ),);
  }
}
