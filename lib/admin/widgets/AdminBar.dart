import 'package:flutter/material.dart';

import '../theme/admin_theme.dart';
import '../screens/home/AdminHomePage.dart';
import '../screens/users/AdminUserManagment.dart';
import '../screens/bins/AdminBinsPage.dart';
import '../screens/reports/AdminReportIssue.dart';
import '../screens/profile/AdminProfile.dart';

class AdminBar extends StatelessWidget {
  final int selectedIndex;

  const AdminBar({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 88,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      decoration: const BoxDecoration(color: AdminTheme.navBar),
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
            icon: Icons.report_problem_outlined,
            selectedIcon: Icons.report_problem,
            label: 'Issues',
          ),
          _buildNavItem(
            context: context,
            index: 4,
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

        late final Widget page;

        switch (index) {
          case 0:
            page = const AdminHomePage(adminName: 'Admin');
            break;
          case 1:
            page = const AdminUserManagment();
            break;
          case 2:
            page = const AdminBinsPage();
            break;
          case 3:
            page = const AdminReportIssue();
            break;
          case 4:
            page = const AdminProfile();
            break;
          default:
            page = const AdminHomePage(adminName: 'Admin');
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
                color: isSelected ? AdminTheme.selectedNav : Colors.transparent,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Icon(
                isSelected ? selectedIcon : icon,
                size: 27,
                color: AdminTheme.textDark,
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
                color:
                    isSelected ? AdminTheme.textMuted : const Color(0xFF49454F),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
