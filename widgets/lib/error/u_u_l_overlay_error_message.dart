import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:widgets/error/u_u_l_error_message.dart';

class UULOverlayErrorMessage extends StatelessWidget {
  final Widget child;

  UULOverlayErrorMessage({this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Container(
          color: Colors.black12,
        ),
        Center(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: .7, sigmaY: .7),
            child: UULErrorMessage(),
          ),
        ),
      ],
    );
  }
}
