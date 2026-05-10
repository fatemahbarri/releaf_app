import 'package:flutter/material.dart';
import 'package:releaf_app/auth/Login.dart';
import 'package:releaf_app/main.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String _text(String key, bool isArabic) {
    final en = {
      'welcomeTitle': 'WELCOME TO\nReLeaf',
      'loginAdmin': 'Login as Admin',
      'loginUser': 'Login as User',
      'languageButton': '🇸🇦 عربي',
    };

    final ar = {
      'welcomeTitle': 'مرحبًا بك في\nReLeaf',
      'loginAdmin': 'تسجيل الدخول كمسؤول',
      'loginUser': 'تسجيل الدخول كمستخدم',
      'languageButton': '🇺🇸 English',
    };

    return isArabic ? ar[key]! : en[key]!;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: localeNotifier,
      builder: (context, locale, _) {
        final isArabic = locale.languageCode == 'ar';

        return Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: Scaffold(
            backgroundColor: const Color(0xFFF3FFE2),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xFF8DC149),
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(140),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x40000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 14,
                            right: isArabic ? null : 18,
                            left: isArabic ? 18 : null,
                            child: _buildLanguageButton(isArabic),
                          ),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _text('welcomeTitle', isArabic),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Image.asset(
                                  'assets/images/releaf_welcome.png',
                                  height: 200,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildButton(
                    text: _text('loginAdmin', isArabic),
                    color: const Color(0xFF499A64),
                    textColor: Colors.white,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const LoginPage(isAdminMode: true),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildButton(
                    text: _text('loginUser', isArabic),
                    color: const Color(0xFF8DC149),
                    textColor: const Color.fromARGB(255, 22, 56, 47),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const LoginPage(isAdminMode: false),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLanguageButton(bool isArabic) {
    return GestureDetector(
      onTap: () async {
        await updateLocale(Locale(isArabic ? 'en' : 'ar'));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: const Color(0xFF8DC149), width: 1.2),
          boxShadow: const [
            BoxShadow(
              color: Color(0x22000000),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.language,
              size: 17,
              color: Color(0xFF499A64),
            ),
            const SizedBox(width: 6),
            Text(
              _text('languageButton', isArabic),
              style: const TextStyle(
                color: Color(0xFF2A2A2A),
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({
    required String text,
    required Color color,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 250,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(40),
          boxShadow: const [
            BoxShadow(
              color: Color(0x40000000),
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
