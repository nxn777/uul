import 'package:flutter/widgets.dart';
import 'package:user_presentation/common/steps_viewmodel.dart';

mixin InhabitantViewModel on StepsViewModel {
  final formKey = GlobalKey<FormState>();
  String apartment;
  String login;
  String name = "";
}