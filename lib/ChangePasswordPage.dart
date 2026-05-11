import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:releaf_app/l10n/app_localizations.dart';

import 'package:releaf_app/admin/widgets/admin_background.dart';
import 'widgets/app_background.dart';
import 'admin/theme/admin_theme.dart';
import 'package:releaf_app/widgets/app_top_bar.dart';

class ChangePasswordPage extends StatefulWidget {
  final bool isAdmin;

  const ChangePasswordPage({
    super.key,
    required this.isAdmin,
  });

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController currentPasswordController =
      TextEditingController();

  final TextEditingController newPasswordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isSaving = false;

  bool hideCurrent = true;
  bool hideNew = true;
  bool hideConfirm = true;

  bool get isDark => Theme.of(context).brightness == Brightness.dark;

  Color get primary =>
      widget.isAdmin ? AdminTheme.primary : const Color(0xFF7FB77E);

  Color get secondary =>
      widget.isAdmin ? AdminTheme.secondary : const Color(0xFF5E9C76);

  Color get border =>
      widget.isAdmin ? AdminTheme.border : const Color(0xFFDCE8D7);

  Color get textDark =>
      widget.isAdmin ? AdminTheme.textDark : const Color(0xFF2F5D50);

  Color get textMedium =>
      widget.isAdmin ? AdminTheme.textMedium : const Color(0xFF4E6A57);

  Color get cardBg =>
      isDark ? const Color(0xFF1F2D28) : Colors.white.withOpacity(0.96);

  Color get fieldBorder => isDark ? Colors.white10 : border;

  Color get textColor => isDark ? Colors.white : textDark;

  Color get hintColor => isDark ? Colors.white54 : textMedium;

  Color get iconColor => isDark ? Colors.white70 : secondary;

  List<Color> get topBarColors => isDark
      ? const [
          Color(0xFF1F2D28),
          Color(0xFF31443B),
        ]
      : [primary, secondary];

  // ─── Admin texts ────────────────────────────────────────────────────────────
  String _adminText(String key, AppLocalizations l) {
    final adminTexts = {
      'changePassword': l.adminChangePassword,
      'savePassword': l.savePassword,
      'currentPassword': l.currentPassword,
      'newPassword': l.newPassword,
      'confirmPassword': l.confirmPassword,
      'noUser': l.noUser,
      'fillAll': l.fillAll,
      'weakPassword': l.weakPassword,
      'noMatch': l.noMatch,
      'passwordSuccess': l.passwordSuccess,
      'wrongPassword': l.wrongPassword,
      'tooWeak': l.tooWeak,
      'reloginPassword': l.reloginPassword,
      'failedPassword': l.failedPassword,
    };
    return adminTexts[key]!;
  }

  // ─── User texts ─────────────────────────────────────────────────────────────
  String _userText(String key, AppLocalizations l) {
    final userTexts = {
      'changePassword': l.changePassword,
      'savePassword': l.savePassword,
      'currentPassword': l.currentPassword,
      'newPassword': l.newPassword,
      'confirmPassword': l.confirmPassword,
      'noUser': l.noUser,
      'fillAll': l.fillAll,
      'weakPassword': l.weakPassword,
      'noMatch': l.noMatch,
      'passwordSuccess': l.passwordSuccess,
      'wrongPassword': l.wrongPassword,
      'tooWeak': l.tooWeak,
      'reloginPassword': l.reloginPassword,
      'failedPassword': l.failedPassword,
    };
    return userTexts[key]!;
  }

  String _t(String key, BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return widget.isAdmin ? _adminText(key, l) : _userText(key, l);
  }

  // ────────────────────────────────────────────────────────────────────────────

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: secondary,
      ),
    );
  }

  Future<void> _changePassword() async {
    final user = FirebaseAuth.instance.currentUser;

    final currentPassword = currentPasswordController.text.trim();
    final newPassword = newPasswordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (user == null || user.email == null) {
      _showMessage(_t('noUser', context));
      return;
    }

    if (currentPassword.isEmpty ||
        newPassword.isEmpty ||
        confirmPassword.isEmpty) {
      _showMessage(_t('fillAll', context));
      return;
    }

    final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$');

    if (!passwordRegex.hasMatch(newPassword)) {
      _showMessage(_t('weakPassword', context));
      return;
    }

    if (newPassword != confirmPassword) {
      _showMessage(_t('noMatch', context));
      return;
    }

    try {
      setState(() => isSaving = true);

      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );

      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);

      if (!mounted) return;

      _showMessage(_t('passwordSuccess', context));
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
        _showMessage(_t('wrongPassword', context));
      } else if (e.code == 'weak-password') {
        _showMessage(_t('tooWeak', context));
      } else if (e.code == 'requires-recent-login') {
        _showMessage(_t('reloginPassword', context));
      } else {
        _showMessage(e.message ?? _t('failedPassword', context));
      }
    } catch (_) {
      if (!mounted) return;
      _showMessage(_t('failedPassword', context));
    } finally {
      if (mounted) setState(() => isSaving = false);
    }
  }

  Widget _passwordField({
    required TextEditingController controller,
    required String hint,
    required bool obscure,
    required VoidCallback onToggle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: fieldBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.22 : 0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: TextStyle(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          icon: Icon(Icons.lock_outline_rounded, color: iconColor),
          hintText: hint,
          hintStyle: TextStyle(color: hintColor),
          border: InputBorder.none,
          suffixIcon: IconButton(
            onPressed: onToggle,
            icon: Icon(
              obscure
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: hintColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _lockCircle() {
    return Container(
      width: 110,
      height: 110,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: isDark
              ? const [Color(0xFF1F2D28), Color(0xFF31443B)]
              : [secondary, textDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: isDark ? Colors.white24 : Colors.white,
          width: 6,
        ),
      ),
      child: const Icon(
        Icons.lock_reset_rounded,
        color: Colors.white,
        size: 58,
      ),
    );
  }

  Widget _saveButton() {
    return GestureDetector(
      onTap: isSaving ? null : _changePassword,
      child: Opacity(
        opacity: isSaving ? 0.6 : 1,
        child: Container(
          width: double.infinity,
          height: 56,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primary, secondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(28),
          ),
          child: isSaving
              ? const CircularProgressIndicator(color: Colors.white)
              : Text(
                  _t('savePassword', context),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _pageContent() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: Column(
            children: [
              AppTopBar(
                title: _t('changePassword', context),
                icon: Icons.lock_reset_rounded,
                showBackButton: true,
                showNotifications: false,
                gradientColors: topBarColors,
              ),
              const SizedBox(height: 28),
              _lockCircle(),
              const SizedBox(height: 24),
              _passwordField(
                controller: currentPasswordController,
                hint: _t('currentPassword', context),
                obscure: hideCurrent,
                onToggle: () => setState(() => hideCurrent = !hideCurrent),
              ),
              _passwordField(
                controller: newPasswordController,
                hint: _t('newPassword', context),
                obscure: hideNew,
                onToggle: () => setState(() => hideNew = !hideNew),
              ),
              _passwordField(
                controller: confirmPasswordController,
                hint: _t('confirmPassword', context),
                obscure: hideConfirm,
                onToggle: () => setState(() => hideConfirm = !hideConfirm),
              ),
              const SizedBox(height: 18),
              _saveButton(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isAdmin) {
      return AdminBackground(child: _pageContent());
    }
    return AppBackground(child: _pageContent());
  }
}
