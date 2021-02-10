import 'package:di/src/dependencies_provider.dart';
import 'package:persistence_api/persistence_api.dart';
import 'package:rest/rest.dart';

class GlobalDependencies {
  final KVStore kvStore;
  final UULDio uulDio;

  DependenciesProvider _dependenciesProvider;
  DependenciesProvider get dependenciesProvider {
    if (_dependenciesProvider == null) {
      _dependenciesProvider = DependenciesProvider(this);
    }
    return _dependenciesProvider;
  }

  GlobalDependencies({KVStore kvStore})
      : uulDio = UULDio(kvStore),
        kvStore = kvStore;
}
