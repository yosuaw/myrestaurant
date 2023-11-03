import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  // static const DARK_THEME = 'DARK_THEME';
  static const dailyReminder = 'DAILY_RESTAURANT';
  static const profileName = 'PROFILE_NAME';

  // Future<bool> get isDarkTheme async {
  //   final prefs = await sharedPreferences;
  //   return prefs.getBool(DARK_THEME) ?? false;
  // }

  // void setDarkTheme(bool value) async {
  //   final prefs = await sharedPreferences;
  //   prefs.setBool(DARK_THEME, value);
  // }

  Future<bool> get isDailyReminderActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(dailyReminder) ?? false;
  }

  void setDailyReminder(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(dailyReminder, value);
  }

  Future<String> get getProfileName async {
    final prefs = await sharedPreferences;
    return prefs.getString(profileName) ?? '';
  }

  void setProfileName(String value) async {
    final prefs = await sharedPreferences;
    prefs.setString(profileName, value);
  }
}
