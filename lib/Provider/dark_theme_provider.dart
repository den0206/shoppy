import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  static const key = "THEMESTATUS";
  SharedPreferences _preferences;

  bool _darkMode;
  bool get darkMode => _darkMode;

  ThemeData buildTheme() => _darkMode
      ? ThemeData.dark().copyWith(
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            foregroundColor: Colors.white,
          ),
          textSelectionTheme: TextSelectionThemeData(
            selectionColor: Colors.white,
          ),
          backgroundColor: Colors.black,
        )
      : ThemeData.light().copyWith(
          textSelectionTheme: TextSelectionThemeData(
            selectionColor: Colors.black,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey,
          ),
          backgroundColor: Colors.white,
        );

  ThemeProvider() {
    _darkMode = false;
    _loadPreferences();
  }

  _initialPreferences() async {
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
  }

  _savePreferences() async {
    await _initialPreferences();
    _preferences.setBool(key, _darkMode);
  }

  _loadPreferences() async {
    await _initialPreferences();
    _darkMode = _preferences.getBool(key) ?? false;
    print(_darkMode);
    notifyListeners();
  }

  toggleButtons() {
    _darkMode = !_darkMode;
    _savePreferences();
    notifyListeners();
  }
}
