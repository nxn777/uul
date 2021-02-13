import 'package:user_presentation/common/steps_viewmodel.dart';

typedef StepValidator = bool Function(dynamic viewModel);
typedef StepEraser = void Function(dynamic viewModel);
typedef StepEnabler = bool Function(dynamic viewModel);
