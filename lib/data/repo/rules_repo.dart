import 'package:UUL_Gym/models/rules.dart';

class RulesRepo {
  Future<Rules> loadRules() => Future.delayed(Duration(seconds: 1), () => Rules());
}
