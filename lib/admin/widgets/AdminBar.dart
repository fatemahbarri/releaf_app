import 'package:flutter/material.dart';
import 'package:releaf_app/l10n/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final navBg = isDark ? const Color(0xFF1F2D28) : AdminTheme.navBar;
    final selectedBg = isDark
        ? Colors.white.withOpacity(0.10)
        : AdminTheme.primary.withOpacity(0.25);
    final selectedColor = isDark ? Colors.white : AdminTheme.primary;
    final unselectedColor = isDark ? Colors.white60 : AdminTheme.textMuted;

    return Container(
      decoration: BoxDecoration(
        color: navBg,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(22),
        ),
        border: Border(
          top: BorderSide(
            color: isDark ? Colors.white10 : Colors.transparent,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.28 : 0.08),
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
            label: l10n.adminNavHome,
            selectedBg: selectedBg,
            selectedColor: selectedColor,
            unselectedColor: unselectedColor,
          ),
          _buildNavItem(
            context: context,
            index: 1,
            icon: Icons.group_outlined,
            selectedIcon: Icons.group,
            label: l10n.adminNavUsers,
            selectedBg: selectedBg,
            selectedColor: selectedColor,
            unselectedColor: unselectedColor,
          ),
          _buildNavItem(
            context: context,
            index: 2,
            icon: Icons.location_on_outlined,
            selectedIcon: Icons.location_on,
            label: l10n.adminNavBins,
            selectedBg: selectedBg,
            selectedColor: selectedColor,
            unselectedColor: unselectedColor,
          ),
          _buildNavItem(
            context: context,
            index: 3,
            icon: Icons.report_problem_outlined,
            selectedIcon: Icons.report_problem,
            label: l10n.adminNavIssues,
            selectedBg: selectedBg,
            selectedColor: selectedColor,
            unselectedColor: unselectedColor,
          ),
          _buildNavItem(
            context: context,
            index: 4,
            icon: Icons.settings_outlined,
            selectedIcon: Icons.settings,
            label: l10n.adminNavProfile,
            selectedBg: selectedBg,
            selectedColor: selectedColor,
            unselectedColor: unselectedColor,
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
    required Color selectedBg,
    required Color selectedColor,
    required Color unselectedColor,
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
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? selectedBg : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
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
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? selectedColor : unselectedColor,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}