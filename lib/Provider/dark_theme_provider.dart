import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkThemeProvider extends ChangeNotifier {
  static const key = "THEMESTATUS";
  SharedPreferences _preferences;

  bool _darkMode;
  bool get darkMode => _darkMode;

  ThemeData buildTheme() => _darkMode
      ? ThemeData.dark().copyWith(
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            foregroundColor: Colors.white,
          ),
        )
      : ThemeData.light().copyWith(
          textSelectionTheme: TextSelectionThemeData(
          selectionColor: Colors.blue,
        ));

  DarkThemeProvider() {
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
    notifyListeners();
  }

  toggleButtons() {
    _darkMode = !_darkMode;
    _savePreferences();
    notifyListeners();
  }
}
