import 'package:flutter/material.dart';
import 'AdminHomePage.dart';
import 'AdminUserManagment.dart';
import 'AdminBinManagment.dart';
import 'AdminProfileEdit.dart';

class AdminBar extends StatelessWidget {
  final int selectedIndex;

  const AdminBar({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 88,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: const BoxDecoration(color: Color(0xFFCDE9C7)),
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
            icon: Icons.group_outlined,
            selectedIcon: Icons.group,
            label: 'Users',
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
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        if (index == selectedIndex) return;

        Widget page;

        switch (index) {
          case 0:
            page = const AdminHomePage();
            break;
          case 1:
            page = const AdminUserManagment();
            break;
          case 2:
            page = const AdminBinManagment();
            break;
          case 3:
            page = const AdminProfileEdit();
            break;
          default:
            page = const AdminHomePage();
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: SizedBox(
        width: 78,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 70,
              height: 34,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFFAFCDA8)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Icon(
                isSelected ? selectedIcon : icon,
                size: 30,
                color: const Color(0xFF2A2A2A),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? const Color(0xFF625B71)
                    : const Color(0xFF49454F),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
