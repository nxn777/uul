import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class ColoredStatusBar extends StatelessWidget {
  const ColoredStatusBar({
    Key key,
    this.color,
    this.child,
    this.brightness = Brightness.light,
  }) : super(key: key);

  final Color color;
  final Widget child;
  final Brightness brightness;

  @override
  Widget build(BuildContext context) {
    final defaultColor = Colors.white;
    final androidIconBrightness =
    brightness == Brightness.dark ? Brightness.light : Brightness.dark;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: color ?? defaultColor,
        statusBarIconBrightness: androidIconBrightness,
        statusBarBrightness: brightness,
      ),
      child: Container(
        color: color ?? defaultColor,
        child: SafeArea(
          bottom: false,
          child: Container(
            child: child,
          ),
        ),
      ),
    );
  }
}