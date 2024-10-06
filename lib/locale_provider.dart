import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  Locale? _locale;

  Locale get locale => _locale ?? const Locale('en');

  LocaleProvider() {
    _loadLocale();
  }

  void _loadLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? localeCode = prefs.getString('locale');
    if (localeCode != null) {
      _locale = Locale(localeCode);
    }
    notifyListeners();
  }

  void setLocale(String localeCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _locale = Locale(localeCode);
    prefs.setString('locale', localeCode);
    notifyListeners();
  }

  void clearLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _locale = const Locale('en');
    prefs.remove('locale');
    notifyListeners();
  }
}
