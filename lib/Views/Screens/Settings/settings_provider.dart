
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier{

   ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  SettingsProvider() {
    _loadThemeMode();
  }

 Future<void> _loadThemeMode() async {

            final prefs =await SharedPreferences.getInstance();

    String? theme =  prefs.getString('themeMode');
    if (theme != null) {
      _themeMode = theme == 'dark' ? ThemeMode.dark : ThemeMode.light;
      notifyListeners();
    }
  }

  Future<void> toggleTheme() async {
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
      final prefs =await SharedPreferences.getInstance();
     await prefs.setString('themeMode','dark'); 
    } else {
      _themeMode = ThemeMode.light;
            final prefs =await SharedPreferences.getInstance();
      await prefs.setString('themeMode','light');
    }
    notifyListeners();
  }
}