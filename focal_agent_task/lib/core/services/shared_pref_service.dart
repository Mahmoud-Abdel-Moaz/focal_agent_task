import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferences? _prefs;


  static Future<void> saveData({required String key,required String value}) async {
    _prefs = _prefs ?? await SharedPreferences.getInstance();
    _prefs?.setString(key, value);
  }

  static Future<String?> get(String key) async {
    _prefs = _prefs ?? await SharedPreferences.getInstance();
    return _prefs?.getString(key);
  }

}