import 'package:UUL_Gym/data/repo/user_repo.dart';
import 'package:UUL_Gym/di/global_dependencies.dart';
import 'package:UUL_Gym/screens/login/login_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class LoginScreenBuilder {
  LoginScreenBuilder._();

  static LoginViewModel buildAndRunVM(BuildContext context) {
    var globalDependencies = Provider.of<GlobalDependencies>(context, listen: false);
    var userRepo = UserRepo(globalDependencies.kvStore);
    return LoginViewModel(userRepo);
  }
}