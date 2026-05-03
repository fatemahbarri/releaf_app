import 'package:flutter/material.dart';

import 'package:releaf_app/user/Home/HomePageUser.dart';
import 'package:releaf_app/user/profile/Profile.dart';
import 'package:releaf_app/user/Bins/LocationPage.dart';
import 'package:releaf_app/user/classification/image_classifier_screen.dart';

class UserBottomNav extends StatelessWidget {
  final int currentIndex;

  const UserBottomNav({
    super.key,
    required this.currentIndex,
  });

  static const Color primary = Color(0xFF7FB77E);
  static const Color lightGreen = Color(0xFFEAF6E3);
  static const Color textDark = Color(0xFF2F5D50);
  static const Color textMedium = Color(0xFF4E6A57);

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final Color navBg = isDark ? const Color(0xFF1A2520) : lightGreen;

    return Container(
      width: double.infinity,
      height: 88,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: navBg,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(26),
        ),
        border: Border(
          top: BorderSide(
            color: isDark ? const Color(0xFF355246) : Colors.transparent,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.30 : 0.06),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildNavItem(
            context: context,
            index: 0,
            icon: Icons.home_outlined,
            selectedIcon: Icons.home_rounded,
            label: 'Home',
          ),
          _buildNavItem(
            context: context,
            index: 1,
            icon: Icons.camera_alt_outlined,
            selectedIcon: Icons.camera_alt_rounded,
            label: 'Classify',
          ),
          _buildNavItem(
            context: context,
            index: 2,
            icon: Icons.location_on_outlined,
            selectedIcon: Icons.location_on,
            label: 'Bins',
          ),
          _buildNavItem(
            context: context,
            index: 3,
            icon: Icons.settings_outlined,
            selectedIcon: Icons.settings,
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required int index,
    required IconData icon,
    required IconData selectedIcon,
    required String label,
  }) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final bool isSelected = currentIndex == index;

    final Color selectedBg = isDark
        ? const Color(0xFF2F5D50).withOpacity(0.45)
        : primary.withOpacity(0.25);

    final Color selectedColor = isDark ? Colors.white : textDark;

    final Color unselectedColor = isDark ? const Color(0xFFB7C8BC) : textMedium;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (index == currentIndex) return;

          late final Widget page;

          switch (index) {
            case 0:
              page = const HomePageUser();
              break;
            case 1:
              page = const ImageClassifierScreen();
              break;
            case 2:
              page = const LocationPage();
              break;
            case 3:
              page = const Profile(
                name: '',
                email: '',
              );
              break;
            default:
              page = const HomePageUser();
          }

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => page),
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? selectedBg : Colors.transparent,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Icon(
                isSelected ? selectedIcon : icon,
                size: 26,
                color: isSelected ? selectedColor : unselectedColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? selectedColor : unselectedColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
