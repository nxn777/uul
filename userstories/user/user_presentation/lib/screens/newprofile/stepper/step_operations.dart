import '../new_profile_viewmodel.dart';

typedef NewProfileStepValidator = bool Function(NewProfileViewModel);
typedef NewProfileStepEraser = void Function(NewProfileViewModel);
typedef NewProfileStepEnabler = bool Function(NewProfileViewModel);