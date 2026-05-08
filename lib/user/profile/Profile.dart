import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:releaf_app/l10n/app_localizations.dart';
import 'package:releaf_app/widgets/app_background.dart';
import 'package:releaf_app/user/UserWidgets/UserBottomNav.dart';
import 'package:releaf_app/auth/Login.dart';
import 'package:releaf_app/widgets/app_top_bar.dart';
import 'package:releaf_app/user/profile/ProfileEdit.dart';
import 'package:releaf_app/user/issues/ReportIssueUser.dart';
import 'package:releaf_app/ChangePasswordPage.dart';
import 'package:releaf_app/AboutReLeafPage.dart';
import 'package:releaf_app/main.dart';

class Profile extends StatefulWidget {
  final String name;
  final String email;

  const Profile({
    super.key,
    required this.name,
    required this.email,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String userName = 'User';
  String userEmail = '';

  bool isLoading = true;
  bool get isDarkMode => Theme.of(context).brightness == Brightness.dark;
  bool get isArabic => Localizations.localeOf(context).languageCode == 'ar';
  bool isDeleting = false;

  static const Color primary = Color(0xFF7FB77E);
  static const Color secondary = Color(0xFF5E9C76);
  static const Color lightGreen = Color(0xFFEAF6E3);
  static const Color textDark = Color(0xFF2F5D50);
  static const Color textMedium = Color(0xFF4E6A57);
  static const Color error = Color(0xFFD64545);

  Color get pageBackground =>
      isDarkMode ? const Color(0xFF10201A) : Colors.transparent;
  Color get cardColor => isDarkMode ? const Color(0xFF1F2F2A) : Colors.white;
  Color get iconBoxColor => isDarkMode ? const Color(0xFF2E4A3D) : lightGreen;
  Color get mainTextColor => isDarkMode ? Colors.white : textDark;
  Color get subTextColor => isDarkMode ? Colors.white70 : textMedium;
  Color get dividerColor => isDarkMode
      ? Colors.white.withOpacity(0.08)
      : Colors.black.withOpacity(0.07);
  Color get cardBorderColor => isDarkMode
      ? Colors.white.withOpacity(0.08)
      : Colors.white.withOpacity(0.8);
  Color get cardShadowColor => isDarkMode
      ? Colors.black.withOpacity(0.25)
      : Colors.black.withOpacity(0.06);
  List<Color> get topBarGradient => isDarkMode
      ? [const Color(0xFF1B3A31), const Color(0xFF2F5D50)]
      : [primary, secondary];

  // ─── Lifecycle ───────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      setState(() => isLoading = false);
      return;
    }

    userEmail = user.email ?? widget.email;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (!mounted) return;

    if (doc.exists) {
      final data = doc.data();
      setState(() {
        userName = data?['name'] ?? widget.name;
        userEmail = data?['email'] ?? userEmail;
        isLoading = false;
      });
    } else {
      setState(() {
        userName = widget.name;
        isLoading = false;
      });
    }
  }

  // ─── Actions ─────────────────────────────────────────────────────────────

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage(isAdminMode: false)),
      (route) => false,
    );
  }

  Future<void> _showChangeEmailDialog() async {
    final l = AppLocalizations.of(context)!;
    final emailController = TextEditingController(text: userEmail);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: cardColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
          content: TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: mainTextColor),
            decoration: InputDecoration(
              labelText: l.newEmail,
              labelStyle: TextStyle(color: subTextColor),
              prefixIcon: Icon(Icons.email_outlined, color: subTextColor),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l.cancel, style: TextStyle(color: subTextColor)),
            ),
            TextButton(
              onPressed: () async {
                final newEmail = emailController.text.trim();
                if (newEmail.isEmpty || !newEmail.contains('@')) {
                  _showMessage(isArabic
                      ? 'يرجى إدخال بريد إلكتروني صحيح.'
                      : 'Please enter a valid email.');
                  return;
                }
                Navigator.pop(context);
                await _changeEmail(newEmail);
              },
              child: Text(l.save, style: const TextStyle(color: secondary)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _changeEmail(String newEmail) async {
    final l = AppLocalizations.of(context)!;
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        _showMessage(l.noUser);
        return;
      }

      await user.verifyBeforeUpdateEmail(newEmail);
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set(
          {'email': newEmail, 'updatedAt': FieldValue.serverTimestamp()},
          SetOptions(merge: true));

      if (!mounted) return;
      setState(() => userEmail = newEmail);
      _showMessage(l.savedWithVerify);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        _showMessage(l.reloginError);
      } else {
        _showMessage(e.message ?? l.failedUpdate);
      }
    } catch (_) {
      _showMessage(l.failedUpdate);
    }
  }

  Future<void> _confirmDeleteAccount() async {
    final l = AppLocalizations.of(context)!;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: cardColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
          title: Text(l.deleteTitle,
              style:
                  const TextStyle(color: error, fontWeight: FontWeight.bold)),
          content:
              Text(l.deleteConfirm, style: TextStyle(color: mainTextColor)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l.cancel, style: TextStyle(color: subTextColor)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _deleteAccount();
              },
              child: Text(l.delete, style: const TextStyle(color: error)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteAccount() async {
    final l = AppLocalizations.of(context)!;
    try {
      setState(() => isDeleting = true);
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        setState(() => isDeleting = false);
        _showMessage(l.noUser);
        return;
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .delete();
      await user.delete();

      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage(isAdminMode: false)),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      setState(() => isDeleting = false);
      if (e.code == 'requires-recent-login') {
        _showMessage(l.reloginError);
      } else {
        _showMessage(e.message ?? l.failedUpdate);
      }
    } catch (_) {
      if (!mounted) return;
      setState(() => isDeleting = false);
      _showMessage(l.failedUpdate);
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: secondary),
    );
  }

  // ─── UI Helpers ──────────────────────────────────────────────────────────

  Widget _profileHeader() {
    return Column(
      children: [
        const SizedBox(height: 18),
        Container(
          width: 126,
          height: 126,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: isDarkMode
                  ? [const Color(0xFF2F5D50), const Color(0xFF10201A)]
                  : [secondary, textDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: isDarkMode ? Colors.white.withOpacity(0.18) : Colors.white,
              width: 6,
            ),
            boxShadow: [
              BoxShadow(
                  color: cardShadowColor,
                  blurRadius: 12,
                  offset: const Offset(0, 5)),
            ],
          ),
          child: const Icon(Icons.person, size: 72, color: Colors.white),
        ),
        const SizedBox(height: 14),
        Text(
          userName,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: mainTextColor, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          userEmail,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: subTextColor, fontSize: 16, fontWeight: FontWeight.w500),
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
        color: cardColor.withOpacity(0.96),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: cardBorderColor),
        boxShadow: [
          BoxShadow(
              color: cardShadowColor,
              blurRadius: 12,
              offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  color: mainTextColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
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
        color: dividerColor);
  }

  Widget _iconBox(IconData icon, {Color iconColor = secondary}) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
          color: iconBoxColor, borderRadius: BorderRadius.circular(14)),
      child: Icon(icon, color: iconColor, size: 27),
    );
  }

  Widget _menuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color iconColor = secondary,
    Color? textColor,
  }) {
    final Color itemTextColor = textColor ?? mainTextColor;
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            _iconBox(icon, iconColor: iconColor),
            const SizedBox(width: 18),
            Expanded(
              child: Text(title,
                  style: TextStyle(
                      color: itemTextColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600)),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: itemTextColor == error ? error : subTextColor,
              size: 20,
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
            child: Text(title,
                style: TextStyle(
                    color: mainTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600)),
          ),
          Switch(
            value: value,
            activeThumbColor: Colors.white,
            activeTrackColor: secondary,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  // ─── Language Toggle Item ────────────────────────────────────────────────

  Widget _languageItem() {
    final l = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          _iconBox(Icons.language_rounded),
          const SizedBox(width: 18),
          Expanded(
            child: Text(
              l.language,
              style: TextStyle(
                  color: mainTextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          ),
          GestureDetector(
            onTap: () {
              updateLocale(
                isArabic ? const Locale('en') : const Locale('ar'),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: iconBoxColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: secondary.withOpacity(0.4)),
              ),
              child: Text(
                l.languageToggle,
                style: const TextStyle(
                    color: secondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Sections ────────────────────────────────────────────────────────────

  Widget _accountSection() {
    final l = AppLocalizations.of(context)!;
    return _sectionCard(
      title: l.account,
      children: [
        _menuItem(
          icon: Icons.person_rounded,
          title: l.editProfile,
          onTap: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProfileEdit(
                  currentName: userName,
                  currentEmail: userEmail,
                ),
              ),
            );
            if (result == true) _loadUserData();
          },
        ),
        _divider(),
        _menuItem(
          icon: Icons.lock_rounded,
          title: l.changePassword,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const ChangePasswordPage(isAdmin: false)),
            );
          },
        ),
      ],
    );
  }

  Widget _settingsSection() {
    final l = AppLocalizations.of(context)!;
    return _sectionCard(
      title: l.settings,
      children: [
        _switchItem(
          icon: isDarkMode ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
          title: l.darkMode,
          value: isDarkMode,
          onChanged: (value) async => await updateTheme(value),
        ),
        _divider(),
        _languageItem(),
      ],
    );
  }

  Widget _supportSection() {
    final l = AppLocalizations.of(context)!;
    return _sectionCard(
      title: l.support,
      children: [
        _menuItem(
          icon: Icons.report_problem_rounded,
          title: l.reportIssue,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ReportIssueUser()),
            );
          },
        ),
        _divider(),
        _menuItem(
          icon: Icons.info_rounded,
          title: l.aboutReleaf,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const AboutReLeafPage(isAdmin: false)),
            );
          },
        ),
      ],
    );
  }

  Widget _logoutButton() {
    final l = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: _logout,
      child: Container(
        width: double.infinity,
        height: 68,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: cardColor.withOpacity(0.96),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: cardBorderColor),
          boxShadow: [
            BoxShadow(
                color: cardShadowColor,
                blurRadius: 12,
                offset: const Offset(0, 5)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.logout_rounded, color: error, size: 28),
            const SizedBox(width: 10),
            Text(l.logout,
                style: const TextStyle(
                    color: error, fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _deleteButton() {
    final l = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: isDeleting ? null : _confirmDeleteAccount,
      child: Container(
        width: double.infinity,
        height: 68,
        margin: const EdgeInsets.only(bottom: 24),
        decoration: BoxDecoration(
          color: cardColor.withOpacity(0.96),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: error.withOpacity(0.35)),
          boxShadow: [
            BoxShadow(
                color: cardShadowColor,
                blurRadius: 12,
                offset: const Offset(0, 5)),
          ],
        ),
        child: Center(
          child: isDeleting
              ? const CircularProgressIndicator(color: error)
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.delete_outline_rounded,
                        color: error, size: 28),
                    const SizedBox(width: 10),
                    Text(l.deleteAccount,
                        style: const TextStyle(
                            color: error,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _darkModeBackground({required Widget child}) {
    if (!isDarkMode) return AppBackground(child: child);
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF10201A), Color(0xFF1F3A31)],
        ),
      ),
      child: child,
    );
  }

  // ─── Build ───────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    if (isLoading) {
      return _darkModeBackground(
        child: const Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(child: CircularProgressIndicator()),
          bottomNavigationBar: UserBottomNav(currentIndex: 3),
        ),
      );
    }

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              AppTopBar(
                title: l.myAccount,
                icon: Icons.person_rounded,
                showBackButton: false,
                showNotifications: false,
                gradientColors: topBarGradient,
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                  child: Column(
                    children: [
                      _profileHeader(),
                      const SizedBox(height: 26),
                      _accountSection(),
                      _settingsSection(),
                      _supportSection(),
                      _logoutButton(),
                      _deleteButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const UserBottomNav(currentIndex: 3),
      ),
    );
  }
}
