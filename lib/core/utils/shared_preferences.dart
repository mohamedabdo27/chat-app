import 'package:shared_preferences/shared_preferences.dart';

class CachData {
  static SharedPreferences? sharedPreferences;

  static inits() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool?> setData(
      {required String key, required dynamic value}) async {
    if (value is int) {
      return await sharedPreferences?.setInt(key, value);
    } else if (value is bool) {
      return await sharedPreferences?.setBool(key, value);
    } else if (value is String) {
      return await sharedPreferences?.setString(key, value);
    }
    return await sharedPreferences?.setDouble(key, value);
  }

  static bool? getBool({required String key}) {
    return sharedPreferences?.getBool(key);
  }

  static String? getString({required String key}) {
    return sharedPreferences?.getString(key);
  }

  static Future<bool>? removeData({required String key}) {
    return sharedPreferences?.remove(key);
  }
}
