import 'package:shared_preferences/shared_preferences.dart';

class KVStore {
  final SharedPreferences _prefs;

  KVStore(this._prefs);

  Future<bool> setString(String key, String value) => _prefs.setString(key, value);
  Future<bool> setInt(String key, int value) => _prefs.setInt(key, value);

  int getInteger(String key, int defaultValue) => _prefs.containsKey(key) ? _prefs.getInt(key) : defaultValue;
}