
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const bool isProduction = bool.fromEnvironment('dart.vm.product');

bool isAndroid(BuildContext context) => Theme.of(context).platform == TargetPlatform.android;