import 'package:di/src/dependencies_provider.dart';
import 'package:persistence_api/persistence_api.dart';
import 'package:rest/rest.dart';
import 'package:navigation/navigation.dart';



class GlobalDependencies {
  final KVStore kvStore;
  final UULDio uulDio;
  final DeepLinkCommandExecutor deepLinkCommandExecutor;

  DependenciesProvider _dependenciesProvider;
  DependenciesProvider get dependenciesProvider {
    if (_dependenciesProvider == null) {
      _dependenciesProvider = DependenciesProvider(this);
    }
    return _dependenciesProvider;
  }

  GlobalDependencies(this.deepLinkCommandExecutor, {KVStore kvStore})
      : uulDio = UULDio(kvStore),
        kvStore = kvStore;
}
