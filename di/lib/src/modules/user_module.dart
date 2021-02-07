import 'package:persistence_api/persistence_api.dart';
import 'package:user_api/user_api.dart';
import 'package:user_data/user_data.dart';

class UserModule {
  final KVStore _kvStore;

  UserModule(this._kvStore);

  UserRepo createUserRepo() => DefaultUserRepo(_kvStore);
}