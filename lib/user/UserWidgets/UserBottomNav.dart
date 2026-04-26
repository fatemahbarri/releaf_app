import 'package:flutter/material.dart';

import 'package:releaf_app/user/HomePageUser.dart';
import 'package:releaf_app/user/Profile.dart';
import 'package:releaf_app/user/LocationPage.dart';
import 'package:releaf_app/classification/image_classifier_screen.dart';

class UserBottomNav extends StatelessWidget {
  final int currentIndex;

  const UserBottomNav({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 88,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      decoration: const BoxDecoration(
        color: const Color(0xFFF3FFE2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
            label: 'Camera',
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
    final bool isSelected = currentIndex == index;

    return GestureDetector(
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
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 58,
              height: 34,
              decoration: BoxDecoration(
                color:
                    isSelected ? const Color(0xFFAED8A5) : Colors.transparent,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Icon(
                isSelected ? selectedIcon : icon,
                size: 27,
                color: const Color(0xFF2F4F35),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? const Color(0xFF2F6B45)
                    : const Color(0xFF49454F),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
