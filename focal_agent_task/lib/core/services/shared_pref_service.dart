import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferences? prefs;


  static Future<void> saveData({required String key,required String value}) async {
     prefs = prefs??await SharedPreferences.getInstance();
    prefs?.setString(key, value);
  }

  static Future<String?> get(String key) async {
    prefs = prefs??await SharedPreferences.getInstance();
    return prefs?.getString(key);
  }

}