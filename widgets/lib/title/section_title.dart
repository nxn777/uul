import 'package:common/common.dart';
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final double textScale;
  SectionTitle(this.title, {this.textScale = 2});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(kSpacingMedium, kSpacingLarge, kSpacingMedium, kSpacingLarge),
      child: Text(
        title,
        style: kRegularActiveTextStyle.copyWith(fontWeight: FontWeight.w900, fontSize: kRegularActiveTextStyle.fontSize * (textScale == null ? 1 : textScale)),
      ),
    );
  }
}
