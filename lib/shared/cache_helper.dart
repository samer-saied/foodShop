import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences _sharedPreferences;

  static Future<SharedPreferences> init() async {
    return _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveCacheData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await _sharedPreferences.setString(key, value);
    if (value is List<String>)
      return await _sharedPreferences.setStringList(key, value);
    if (value is int) return await _sharedPreferences.setInt(key, value);
    if (value is bool) return await _sharedPreferences.setBool(key, value);
    return await _sharedPreferences.setDouble(key, value);
  }

  static dynamic getCacheData({
    required String key,
  }) {
    return init().then((shared) => shared.getStringList(key));
  }

  static Future<bool> removeCacheData({
    required String key,
  }) async {
    return await _sharedPreferences.remove(key);
  }

  static Future<bool> clearCacheData({
    required String key,
  }) async {
    return await _sharedPreferences.clear();
  }
}
