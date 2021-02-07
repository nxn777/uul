import 'package:core/core.dart';

abstract class RulesRepo {
  Future<UULResult<Rules>> loadRules({bool forced = false});
}
