import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../ChangePasswordPage.dart';
import 'package:releaf_app/main.dart';
import '../../widgets/AdminBar.dart';
import '../../widgets/admin_background.dart';
import '../../theme/admin_theme.dart';
import 'AdminProfileEdit.dart';
import '../../../auth/Login.dart';
import 'package:releaf_app/widgets/app_top_bar.dart';

import 'package:releaf_app/AboutReLeafPage.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile({super.key});

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  String adminName = 'Admin';
  String adminEmail = '';
  bool isLoading = true;
  bool isDarkMode = false;

  static const Color secondary = Color(0xFF5E9C76);
  static const Color textDark = Color(0xFF2F5D50);
  static const Color textMedium = Color(0xFF4E6A57);

  Color get pageOverlay =>
      isDarkMode ? Colors.black.withOpacity(0.28) : Colors.transparent;

  Color get cardBg =>
      isDarkMode ? const Color(0xFF1F2D28) : Colors.white.withOpacity(0.96);

  Color get titleColor => isDarkMode ? Colors.white : textDark;

  Color get subtitleColor => isDarkMode ? Colors.white70 : Colors.black54;

  Color get iconBoxBg =>
      isDarkMode ? const Color(0xFF31443B) : const Color(0xFFEAF6E3);

  Color get dividerColor => isDarkMode
      ? Colors.white.withOpacity(0.10)
      : Colors.black.withOpacity(0.07);

  @override
  void initState() {
    super.initState();
    _loadAdminData();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;

    setState(() {
      isDarkMode = prefs.getBool('dark_mode') ?? false;
    });
  }

  Future<void> _saveTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('dark_mode', value);
  }

  Future<void> _loadAdminData() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      if (!mounted) return;
      setState(() => isLoading = false);
      return;
    }

    adminEmail = user.email ?? '';

    try {
      final doc = await FirebaseFirestore.instance
          .collection('admins')
          .doc(user.uid)
          .get();

      if (!mounted) return;

      if (doc.exists) {
        final data = doc.data();

        setState(() {
          adminName = data?['name'] ?? 'Admin';
          adminEmail = data?['email'] ?? adminEmail;
          isLoading = false;
        });
      } else {
        setState(() {
          adminName = 'Admin';
          isLoading = false;
        });
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        adminName = 'Admin';
        isLoading = false;
      });
    }
  }

  Future<void> _openEditPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AdminProfileEdit(
          currentName: adminName,
          currentEmail: adminEmail,
        ),
      ),
    );

    if (result != null && result is Map<String, String>) {
      setState(() {
        adminName = result['name'] ?? adminName;
        adminEmail = result['email'] ?? adminEmail;
      });

      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await FirebaseFirestore.instance
            .collection('admins')
            .doc(user.uid)
            .set({
          'name': adminName,
          'email': adminEmail,
          'role': 'admin',
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      }
    }
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginPage(isAdminMode: true),
      ),
      (route) => false,
    );
  }

  void _showComingSoon(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$title will be available soon'),
        backgroundColor: secondary,
      ),
    );
  }

  Widget _profileHeader() {
    return Column(
      children: [
        const SizedBox(height: 10),
        Container(
          width: 108,
          height: 108,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: isDarkMode
                  ? [
                      const Color(0xFF2F5D50),
                      const Color(0xFF17211D),
                    ]
                  : [
                      secondary,
                      textDark,
                    ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: isDarkMode ? const Color(0xFF31443B) : Colors.white,
              width: 6,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDarkMode ? 0.25 : 0.12),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: const Icon(
            Icons.person_rounded,
            size: 68,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          adminName,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: titleColor,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          adminEmail,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: subtitleColor,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _sectionCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 10),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDarkMode
              ? Colors.white.withOpacity(0.08)
              : Colors.white.withOpacity(0.8),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDarkMode ? 0.18 : 0.06),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: titleColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: const EdgeInsets.only(left: 78),
      height: 1,
      color: dividerColor,
    );
  }

  Widget _iconBox(IconData icon) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: iconBoxBg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(
        icon,
        color: isDarkMode ? Colors.white : secondary,
        size: 27,
      ),
    );
  }

  Widget _menuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            _iconBox(icon),
            const SizedBox(width: 18),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: titleColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: isDarkMode ? Colors.white54 : textMedium,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  Widget _switchItem({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          _iconBox(icon),
          const SizedBox(width: 18),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: titleColor,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Switch(
            value: value,
            activeThumbColor: Colors.white,
            activeTrackColor: secondary,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey.shade300,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _accountSection() {
    return _sectionCard(
      title: 'Account',
      children: [
        _menuItem(
          icon: Icons.person_rounded,
          title: 'Edit Profile',
          onTap: _openEditPage,
        ),
        _divider(),
        _menuItem(
          icon: Icons.lock_rounded,
          title: 'Change Password',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ChangePasswordPage(isAdmin: true),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _settingsSection() {
    return _sectionCard(
      title: 'Settings',
      children: [
        _menuItem(
          icon: Icons.language_rounded,
          title: 'Language',
          onTap: () => _showComingSoon('Language'),
        ),
        _divider(),
        _switchItem(
          icon: Icons.dark_mode_rounded,
          title: 'Dark Mode',
          value: isDarkMode,
          onChanged: (value) async {
            setState(() {
              isDarkMode = value;
            });
            await updateTheme(value);
          },
        ),
      ],
    );
  }

  Widget _supportSection() {
    return _sectionCard(
      title: 'Support',
      children: [
        _menuItem(
          icon: Icons.info_rounded,
          title: 'About ReLeaf',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AboutReLeafPage(isAdmin: true),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _logoutButton() {
    return GestureDetector(
      onTap: _logout,
      child: Container(
        width: double.infinity,
        height: 66,
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDarkMode ? 0.18 : 0.06),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.logout_rounded,
              color: AdminTheme.error,
              size: 27,
            ),
            SizedBox(width: 10),
            Text(
              'Logout',
              style: TextStyle(
                color: AdminTheme.error,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const AdminBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return AdminBackground(
      child: Stack(
        children: [
          Container(color: pageOverlay),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  AppTopBar(
                    title: 'My Account',
                    icon: Icons.person_rounded,
                    showBackButton: false,
                    gradientColors: isDarkMode
                        ? const [
                            Color(0xFF1F2D28),
                            Color(0xFF31443B),
                          ]
                        : const [
                            Color(0xFF7FB77E),
                            Color(0xFF5E9C76),
                          ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
                      child: Column(
                        children: [
                          _profileHeader(),
                          const SizedBox(height: 20),
                          _accountSection(),
                          _settingsSection(),
                          _supportSection(),
                          _logoutButton(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: const AdminBar(selectedIndex: 4),
          ),
        ],
      ),
    );
  }
}
