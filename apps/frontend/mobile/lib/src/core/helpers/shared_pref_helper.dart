import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static SharedPreferences? _sharedPrefs;
  static SharedPrefHelper? _instance;

  static Future<SharedPrefHelper> init() async {
    if (_instance == null) {
      final reference = await SharedPreferences.getInstance();
      _instance = SharedPrefHelper._internal(reference);
    }
    return _instance!;
  }

  SharedPrefHelper._internal(SharedPreferences reference) {
    _sharedPrefs = reference;
  }

  factory SharedPrefHelper() => _instance!;

  static Future<bool> containsKey(String key) async {
    return _sharedPrefs?.containsKey(key) ?? false;
  }

  static Future clear() async {
    await _sharedPrefs?.clear();
  }

  static Future<bool> getBool(String key) async {
    return _sharedPrefs?.getBool(key) ?? false;
  }

  static Future<double> getDouble(String key) async {
    return _sharedPrefs?.getDouble(key) ?? -1;
  }

  static int getInt(String key) {
    return _sharedPrefs?.getInt(key) ?? 0;
  }

  static String getString(String key) {
    return _sharedPrefs?.getString(key) ?? '';
  }

  static Future<void> setBool(String key, dynamic value) async {
    await _sharedPrefs?.setBool(key, value);
  }

  static void setDouble(String key, double value) async {
    _sharedPrefs?.setDouble(key, value);
  }

  static Future setInt(String key, int value) async {
    await _sharedPrefs?.setInt(key, value);
  }

  static Future setString(String key, String value) async {
    await _sharedPrefs?.setString(key, value);
  }

  static Future removeKey(String key) async {
    await _sharedPrefs?.remove(key);
  }
}