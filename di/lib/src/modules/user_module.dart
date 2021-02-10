import 'package:persistence_api/persistence_api.dart';
import 'package:rest/rest.dart';
import 'package:user_api/user_api.dart';
import 'package:user_data/user_data.dart';

class UserModule {
  final KVStore _kvStore;
  final UULDio _uulDio;

  UserModule(this._kvStore, this._uulDio);

  UserRepo createUserRepo() => DefaultUserRepo(_kvStore, DefaultUserApiClient(_uulDio));
}
