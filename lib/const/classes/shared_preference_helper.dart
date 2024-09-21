import 'package:shmart/shmart.dart';

class SharedPreferenceHelper {

  static final SharedPreferenceHelper _instance =
      SharedPreferenceHelper._internal();

  SharedPreferences? _preferences;
  SharedPreferenceHelper._internal();

  factory SharedPreferenceHelper() {
    return _instance;
  }

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  bool get isInitialized => _preferences != null;

  Future<void> setString(String key, String value) async {
    await _preferences?.setString(key, value);
  }

  String? getString(String key) {
    return _preferences?.getString(key);
  }

  Future<void> setInt(String key, int value) async {
    await _preferences?.setInt(key, value);
  }

  int? getInt(String key) {
    return _preferences?.getInt(key);
  }

  Future<void> setBool(String key, bool value) async {
    await _preferences?.setBool(key, value);
  }

  bool? getBool(String key) {
    return _preferences?.getBool(key);
  }

  Future<void> setDouble(String key, double value) async {
    await _preferences?.setDouble(key, value);
  }

  double? getDouble(String key) {
    return _preferences?.getDouble(key);
  }

  Future<void> setStringList(String key, List<String> value) async {
    await _preferences?.setStringList(key, value);
  }

  List<String>? getStringList(String key) {
    return _preferences?.getStringList(key);
  }

  Future<void> remove(String key) async {
    await _preferences?.remove(key);
  }

  Future<void> clear() async {
    await _preferences?.clear();
  }
}
