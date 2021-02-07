import 'package:di/src/dependencies_provider.dart';
import 'package:persistence_api/persistence_api.dart';

class GlobalDependencies {
  final KVStore kvStore;

  DependenciesProvider _dependenciesProvider;
  DependenciesProvider get dependenciesProvider {
    if (_dependenciesProvider == null) {
      _dependenciesProvider = DependenciesProvider(this);
    }
    return dependenciesProvider;
  }

  GlobalDependencies({this.kvStore});
}
