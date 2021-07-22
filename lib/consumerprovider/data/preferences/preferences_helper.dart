import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const NOTIF = 'NOTIF';

  Future<bool> get isNotification async {
    final prefs = await sharedPreferences;
    return prefs.getBool(NOTIF) ?? false;
  }

  void setNotification(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(NOTIF, value);
  }
}