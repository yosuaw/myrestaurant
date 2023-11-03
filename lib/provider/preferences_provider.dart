import 'package:flutter/material.dart';
import 'package:myrestaurant/data/preferences/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    // _getTheme();
    _getDailyReminderPreferences();
    _getProfileName();
  }

  // bool _isDarkTheme = false;
  // bool get isDarkTheme => _isDarkTheme;

  bool _isDailyReminderActive = false;
  bool get isDailyReminderActive => _isDailyReminderActive;

  // ThemeData get themeData => _isDarkTheme ? darkTheme : lightTheme;

  String _profileName = '';
  String get profileName => _profileName;

  // void _getTheme() async {
  //   _isDarkTheme = await preferencesHelper.isDarkTheme;
  //   notifyListeners();
  // }

  // void enableDarkTheme(bool value) {
  //   preferencesHelper.setDarkTheme(value);
  //   _getTheme();
  // }

  void _getDailyReminderPreferences() async {
    _isDailyReminderActive = await preferencesHelper.isDailyReminderActive;
    notifyListeners();
  }

  void enableDailyReminder(bool value) {
    preferencesHelper.setDailyReminder(value);
    _getDailyReminderPreferences();
  }

  void _getProfileName() async {
    _profileName = await preferencesHelper.getProfileName;
    notifyListeners();
  }

  void setProfileName(String value) {
    preferencesHelper.setProfileName(value);
    _getProfileName();
  }
}
