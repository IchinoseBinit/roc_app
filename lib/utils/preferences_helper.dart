import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static late SharedPreferences prefs;

  static String? readKey({required String key}) {
    return prefs.getString(key);
  }

  static write({required String key, required String value}) async {
    await prefs.setString(key, value);
  }

  static remove({required String key}) async {
    await prefs.remove(key);
  }

  static removeAll() async {
    await prefs.clear();
  }
}
