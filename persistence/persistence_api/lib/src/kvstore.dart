abstract class KVStore {
  Future<bool> clearAll();

  Future<bool> setString(String key, String value);

  Future<bool> setStringList(String key, List<String> value);

  Future<bool> setInt(String key, int value);

  int getInteger(String key, int defaultValue);

  String getString(String key, String defaultValue);

  List<String> getStringList(String key);
}
