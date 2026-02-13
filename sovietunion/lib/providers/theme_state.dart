import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Simple ChangeNotifier that holds the [ThemeMode] and persists the
/// user's selection to SharedPreferences under key `themeMode`.
class ThemeState with ChangeNotifier {
  static const _prefKey = 'themeMode';

  final SharedPreferences _prefs;

  ThemeMode _mode;

  ThemeState(this._prefs, [ThemeMode? initial]) : _mode = initial ?? ThemeMode.system;

  ThemeMode get mode => _mode;

  bool get isDark => _mode == ThemeMode.dark;

  Future<void> setMode(ThemeMode mode) async {
    _mode = mode;
    await _prefs.setString(_prefKey, mode.name);
    notifyListeners();
  }

  Future<void> toggleDark(bool dark) => setMode(dark ? ThemeMode.dark : ThemeMode.light);

  /// Loads saved theme from prefs and applies it. If no saved value, keep current.
  void loadFromPrefs() {
    final val = _prefs.getString(_prefKey);
    if (val == null) return;
    switch (val) {
      case 'light':
        _mode = ThemeMode.light;
        break;
      case 'dark':
        _mode = ThemeMode.dark;
        break;
      default:
        _mode = ThemeMode.system;
    }
    notifyListeners();
  }
}
