import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLanguage {
  static final ValueNotifier<Locale> localeNotifier =
      ValueNotifier<Locale>(const Locale('en'));

  static bool get isArabic => localeNotifier.value.languageCode == 'ar';

  static Future<void> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString('app_language') ?? 'en';
    localeNotifier.value = Locale(code);
  }

  static Future<void> changeLanguage(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('app_language', code);
    localeNotifier.value = Locale(code);
  }

  static String text(String key) {
    final ar = isArabic;

    final Map<String, String> en = {
      'welcomeTitle': 'WELCOME TO\nReLeaf',
      'loginAdmin': 'Login as Admin',
      'loginUser': 'Login as User',
      'languageButton': '🇸🇦 عربي',
    };

    final Map<String, String> arMap = {
      'welcomeTitle': 'مرحبًا بك في\nReLeaf',
      'loginAdmin': 'تسجيل الدخول كمسؤول',
      'loginUser': 'تسجيل الدخول كمستخدم',
      'languageButton': '🇺🇸 English',
    };

    return ar ? arMap[key]! : en[key]!;
  }
}
