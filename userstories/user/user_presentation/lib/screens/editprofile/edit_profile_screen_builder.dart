import 'package:di/di.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'edit_profile_viewmodel.dart';

class EditProfileScreenBuilder {
  EditProfileScreenBuilder._();
  static EditProfileViewModel buildAndRunVM(BuildContext context) {
    var globalDependencies = Provider.of<GlobalDependencies>(context, listen: false);
    var userRepo = globalDependencies.dependenciesProvider.userModule.createUserRepo();
    return EditProfileViewModel(userRepo);
  }
}