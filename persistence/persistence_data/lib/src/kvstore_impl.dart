import 'package:persistence_api/persistence_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DefaultKVStore implements KVStore {
  final SharedPreferences _prefs;

  DefaultKVStore(this._prefs);

  Future<bool> clearAll() => _prefs.clear();

  Future<bool> setString(String key, String value) => _prefs.setString(key, value);

  Future<bool> setStringList(String key, List<String> value) => _prefs.setStringList(key, value);

  Future<bool> setInt(String key, int value) => _prefs.setInt(key, value);

  int getInteger(String key, int defaultValue) => _prefs.containsKey(key) ? _prefs.getInt(key) : defaultValue;

  String getString(String key, String defaultValue) => _prefs.containsKey(key) ? _prefs.getString(key) : defaultValue;

  List<String> getStringList(String key) => _prefs.containsKey(key) ? _prefs.getStringList(key) : List.empty();
}
