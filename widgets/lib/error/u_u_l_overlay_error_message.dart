import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:widgets/error/u_u_l_error_message.dart';

class UULOverlayErrorMessage extends StatelessWidget {
  final Widget child;
  final void Function() onCancelTap;
  final void Function() onRetryTap;
  final bool canCancel;
  final String message;

  UULOverlayErrorMessage(this.child, {this.onRetryTap, this.canCancel, this.onCancelTap, this.message});

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
            child: UULErrorMessage(
              onRetryTap: this.onRetryTap,
              onCancelTap: this.onCancelTap,
              canCancel: this.canCancel,
              message: this.message,
            ),
          ),
        ),
      ],
    );
  }
}
