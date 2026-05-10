import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:releaf_app/l10n/app_localizations.dart';

import 'firebase_options.dart';
import 'SplashScreen.dart';
import 'user/classification/tflite_helper.dart';

// ─── Theme ───────────────────────────────────────────────────────────────────

final ValueNotifier<ThemeMode> themeNotifier =
    ValueNotifier<ThemeMode>(ThemeMode.light);

Future<void> loadTheme() async {
  final prefs = await SharedPreferences.getInstance();
  final isDarkMode = prefs.getBool('dark_mode') ?? false;
  themeNotifier.value = isDarkMode ? ThemeMode.dark : ThemeMode.light;
}

Future<void> updateTheme(bool isDarkMode) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('dark_mode', isDarkMode);
  themeNotifier.value = isDarkMode ? ThemeMode.dark : ThemeMode.light;
}

// ─── Locale ──────────────────────────────────────────────────────────────────

final ValueNotifier<Locale> localeNotifier =
    ValueNotifier<Locale>(const Locale('en'));

Future<void> loadLocale() async {
  final prefs = await SharedPreferences.getInstance();
  final langCode = prefs.getString('language') ?? 'en';
  localeNotifier.value = Locale(langCode);
}

Future<void> updateLocale(Locale locale) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('language', locale.languageCode);
  localeNotifier.value = locale;
}

// ─── Main ─────────────────────────────────────────────────────────────────────

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await TFLiteHelper.init();

  await loadTheme();
  await loadLocale();

  runApp(const ReLeafApp());
}

// ─── Scroll Behavior ──────────────────────────────────────────────────────────

class NoStretchScrollBehavior extends ScrollBehavior {
  const NoStretchScrollBehavior();

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const ClampingScrollPhysics();
  }
}

// ─── App ──────────────────────────────────────────────────────────────────────

class ReLeafApp extends StatelessWidget {
  const ReLeafApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentTheme, _) {
        return ValueListenableBuilder<Locale>(
          valueListenable: localeNotifier,
          builder: (context, currentLocale, _) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'ReLeaf',
              scrollBehavior: const NoStretchScrollBehavior(),
              themeMode: currentTheme,

              // ── Localization ──
              locale: currentLocale,
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],

              // ── Light Theme ──
              theme: ThemeData(
                brightness: Brightness.light,
                fontFamily: 'Poppins',
                scaffoldBackgroundColor: const Color(0xFFF7FBF2),
                primaryColor: const Color(0xFF7FB77E),
                colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color(0xFF7FB77E),
                  brightness: Brightness.light,
                ),
              ),

              // ── Dark Theme ──
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                fontFamily: 'Poppins',
                scaffoldBackgroundColor: const Color(0xFF0F1713),
                primaryColor: const Color(0xFF7FB77E),
                colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color(0xFF7FB77E),
                  brightness: Brightness.dark,
                ),
              ),

              home: const SplashScreen(),
            );
          },
        );
      },
    );
  }
}
