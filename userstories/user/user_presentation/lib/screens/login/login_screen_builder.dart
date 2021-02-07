import 'package:di/di.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'login_viewmodel.dart';

class LoginScreenBuilder {
  LoginScreenBuilder._();

  static LoginViewModel buildAndRunVM(BuildContext context) {
    var globalDependencies = Provider.of<GlobalDependencies>(context, listen: false);
    var userRepo = globalDependencies.dependenciesProvider.userModule.createUserRepo();
    return LoginViewModel(userRepo);
  }
}
