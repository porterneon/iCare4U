import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage extends ChangeNotifier {
  Locale _appLocale = Locale('en');

  Locale get appLocal => _appLocale ?? Locale("en");
  fetchLocale() async {
    print("fetchng stored locale");
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      _appLocale = Locale('en');
      return Null;
    }
    _appLocale = Locale(prefs.getString('language_code'));
    return Null;
  }

  void changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();

    print('appLocal: $_appLocale input type: $type');

    if (_appLocale == type) {
      return;
    }
    print("change language");
    if (type == Locale("pl")) {
      _appLocale = Locale("pl");
      await prefs.setString('language_code', 'pl');
      await prefs.setString('countryCode', 'PL');
    } else {
      _appLocale = Locale("en");
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', 'US');
    }
    print("send language change notification");
    notifyListeners();
  }
}
