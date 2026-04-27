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
      decoration: BoxDecoration(
        color: AdminTheme.navBar,

        // ✅ Rounded like user bar
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(22),
        ),

        // ✅ Shadow like user bar
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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

    return Expanded(
      child: GestureDetector(
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

        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ✅ Same pill design as user bar
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AdminTheme.primary.withOpacity(0.25)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  isSelected ? selectedIcon : icon,
                  size: 26,
                  color: isSelected
                      ? AdminTheme.primary
                      : AdminTheme.textMuted,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected
                      ? AdminTheme.primary
                      : AdminTheme.textMuted,
                  fontWeight:
                      isSelected ? FontWeight.bold : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}