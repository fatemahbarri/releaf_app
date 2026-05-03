import 'package:flutter/material.dart';

import 'package:releaf_app/widgets/app_background.dart';
import 'package:releaf_app/admin/widgets/admin_background.dart';
import 'package:releaf_app/widgets/app_top_bar.dart';

import 'package:releaf_app/admin/widgets/AdminBar.dart';
import 'package:releaf_app/user/UserWidgets/UserBottomNav.dart';
import 'package:releaf_app/admin/theme/admin_theme.dart';

class AboutReLeafPage extends StatelessWidget {
  final bool isAdmin;

  const AboutReLeafPage({
    super.key,
    required this.isAdmin,
  });

  static const Color userPrimary = Color(0xFF7FB77E);
  static const Color userSecondary = Color(0xFF5E9C76);
  static const Color userTextDark = Color(0xFF2F5D50);
  static const Color userTextMedium = Color(0xFF4E6A57);
  static const Color userLightGreen = Color(0xFFEAF6E3);

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final Color primary = isAdmin ? AdminTheme.primary : userPrimary;
    final Color secondary = isAdmin ? AdminTheme.secondary : userSecondary;

    final Color titleColor = isDark ? Colors.white : userTextDark;
    final Color subTextColor = isDark ? Colors.white70 : userTextMedium;

    final Color cardBg = isDark
        ? const Color(0xFF1F2F2A).withOpacity(0.96)
        : Colors.white.withOpacity(0.96);

    final Color iconBoxBg = isDark ? const Color(0xFF2E4A3D) : userLightGreen;

    final Color borderColor = isDark
        ? Colors.white.withOpacity(0.08)
        : Colors.white.withOpacity(0.75);

    final List<Color> topBarGradient = isDark
        ? const [
            Color(0xFF1B3A31),
            Color(0xFF2F5D50),
          ]
        : [
            primary,
            secondary,
          ];

    final Widget page = Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            AppTopBar(
              title: 'About ReLeaf',
              icon: Icons.eco_rounded,
              showBackButton: true,
              showNotifications: false,
              gradientColors: topBarGradient,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
                child: Column(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: iconBoxBg,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color:
                              isDark ? Colors.white.withOpacity(0.18) : primary,
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(
                              isDark ? 0.25 : 0.08,
                            ),
                            blurRadius: 12,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/images/Releaf_logo.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'ReLeaf',
                      style: TextStyle(
                        color: titleColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Smart Waste Classification & Recycling Assistant',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: subTextColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _aboutCard(
                      title: 'What is ReLeaf?',
                      icon: Icons.info_outline_rounded,
                      text:
                          'ReLeaf is a smart recycling application designed to help users classify waste items, understand how to recycle them, and find nearby recycling bins or locations.',
                      cardBg: cardBg,
                      iconBoxBg: iconBoxBg,
                      titleColor: titleColor,
                      subTextColor: subTextColor,
                      primary: primary,
                      borderColor: borderColor,
                      isDark: isDark,
                    ),
                    _aboutCard(
                      title: 'Main Features',
                      icon: Icons.star_outline_rounded,
                      text:
                          'The app includes image-based waste classification, recycling guidance, nearby bin locations, and a smart assistant that answers recycling-related questions.',
                      cardBg: cardBg,
                      iconBoxBg: iconBoxBg,
                      titleColor: titleColor,
                      subTextColor: subTextColor,
                      primary: primary,
                      borderColor: borderColor,
                      isDark: isDark,
                    ),
                    _aboutCard(
                      title: isAdmin ? 'Admin Role' : 'User Experience',
                      icon: isAdmin
                          ? Icons.admin_panel_settings_outlined
                          : Icons.person_outline_rounded,
                      text: isAdmin
                          ? 'Admins can manage users, recycling bins, reported issues, and review app activity to keep the system organized and reliable.'
                          : 'Users can classify waste, explore recycling options, report issues, and access helpful information through the app.',
                      cardBg: cardBg,
                      iconBoxBg: iconBoxBg,
                      titleColor: titleColor,
                      subTextColor: subTextColor,
                      primary: primary,
                      borderColor: borderColor,
                      isDark: isDark,
                    ),
                    _aboutCard(
                      title: 'Our Goal',
                      icon: Icons.public_rounded,
                      text:
                          'Our goal is to encourage better recycling habits and make waste sorting easier through technology, artificial intelligence, and accessible recycling information.',
                      cardBg: cardBg,
                      iconBoxBg: iconBoxBg,
                      titleColor: titleColor,
                      subTextColor: subTextColor,
                      primary: primary,
                      borderColor: borderColor,
                      isDark: isDark,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Version 1.0.0',
                      style: TextStyle(
                        color: subTextColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: isAdmin
          ? const AdminBar(selectedIndex: 4)
          : const UserBottomNav(currentIndex: 3),
    );

    return isAdmin ? AdminBackground(child: page) : AppBackground(child: page);
  }

  Widget _aboutCard({
    required String title,
    required String text,
    required IconData icon,
    required Color cardBg,
    required Color iconBoxBg,
    required Color titleColor,
    required Color subTextColor,
    required Color primary,
    required Color borderColor,
    required bool isDark,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.22 : 0.07),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconBoxBg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: isDark ? Colors.white70 : primary,
              size: 26,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: titleColor,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  text,
                  style: TextStyle(
                    color: subTextColor,
                    fontSize: 14,
                    height: 1.45,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
