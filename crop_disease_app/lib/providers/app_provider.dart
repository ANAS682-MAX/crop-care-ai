import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');
  bool _isLoggedIn = false;
  String? _userId;
  String? _token;

  Locale get locale => _locale;
  bool get isLoggedIn => _isLoggedIn;
  String? get userId => _userId;
  String? get token => _token;

  AppProvider() {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString('language') ?? 'en';
    _locale = Locale(langCode);
    _token = prefs.getString('token');
    _userId = prefs.getString('userId');
    _isLoggedIn = _token != null;
    notifyListeners();
  }

  Future<void> setLocale(String languageCode) async {
    _locale = Locale(languageCode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', languageCode);
    notifyListeners();
  }

  Future<void> login(String token, String userId) async {
    _token = token;
    _userId = userId;
    _isLoggedIn = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('userId', userId);
    notifyListeners();
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _isLoggedIn = false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('userId');
    notifyListeners();
  }
}
