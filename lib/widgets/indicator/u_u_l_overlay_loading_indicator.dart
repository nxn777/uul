import 'dart:ui';

import 'package:UUL_Gym/widgets/indicator/u_u_l_loading_indicator.dart';
import 'package:flutter/material.dart';

class UULOverlayLoadingIndicator extends StatelessWidget {
  final Widget child;

  UULOverlayLoadingIndicator({this.child});

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
            child: UULLoadingIndicator(),
          ),
        ),
      ],
    );
  }
}
