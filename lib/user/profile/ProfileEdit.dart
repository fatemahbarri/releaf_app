import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:releaf_app/widgets/app_background.dart';
import 'package:releaf_app/user/UserWidgets/UserBottomNav.dart';
import 'package:releaf_app/widgets/app_top_bar.dart';

class ProfileEdit extends StatefulWidget {
  final String currentName;
  final String currentEmail;

  const ProfileEdit({
    super.key,
    required this.currentName,
    required this.currentEmail,
  });

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;

  bool isSaving = false;

  static const Color primary = Color(0xFF7FB77E);
  static const Color secondary = Color(0xFF5E9C76);
  static const Color lightGreen = Color(0xFFEAF6E3);
  static const Color textDark = Color(0xFF2F5D50);
  static const Color textMedium = Color(0xFF4E6A57);

  bool get isDarkMode => Theme.of(context).brightness == Brightness.dark;

  Color get cardColor => isDarkMode ? const Color(0xFF1F2F2A) : Colors.white;

  Color get iconBoxColor => isDarkMode ? const Color(0xFF2E4A3D) : lightGreen;

  Color get mainTextColor => isDarkMode ? Colors.white : textDark;

  Color get subTextColor => isDarkMode ? Colors.white70 : textMedium;

  Color get fieldBorderColor =>
      isDarkMode ? Colors.white.withOpacity(0.08) : const Color(0xFFDCE8D7);

  Color get shadowColor => isDarkMode
      ? Colors.black.withOpacity(0.25)
      : Colors.black.withOpacity(0.06);

  @override
  void initState() {
    super.initState();

    final parts = widget.currentName.trim().split(' ');
    final firstName = parts.isNotEmpty ? parts.first : '';
    final lastName = parts.length > 1 ? parts.sublist(1).join(' ') : '';

    firstNameController = TextEditingController(text: firstName);
    lastNameController = TextEditingController(text: lastName);
    emailController = TextEditingController(text: widget.currentEmail);
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      _showMessage('No user is logged in.');
      return;
    }

    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();
    final newEmail = emailController.text.trim();
    final fullName = '$firstName $lastName'.trim();

    if (firstName.isEmpty || newEmail.isEmpty || !newEmail.contains('@')) {
      _showMessage('Please enter a valid name and email.');
      return;
    }

    try {
      setState(() => isSaving = true);

      final oldEmail = user.email ?? widget.currentEmail;

      if (newEmail != oldEmail) {
        await user.verifyBeforeUpdateEmail(newEmail);
      }

      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'name': fullName,
        'email': newEmail,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      if (!mounted) return;

      _showMessage(
        newEmail != oldEmail
            ? 'Saved. Please verify your new email to complete the change.'
            : 'Profile updated successfully.',
      );

      Navigator.pop(context, true);
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      setState(() => isSaving = false);

      if (e.code == 'requires-recent-login') {
        _showMessage(
          'Please log out and log in again, then change your email.',
        );
      } else {
        _showMessage(e.message ?? 'Failed to update profile.');
      }
    } catch (_) {
      if (!mounted) return;
      setState(() => isSaving = false);
      _showMessage('Failed to update profile.');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: secondary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final fullName =
        '${firstNameController.text.trim()} ${lastNameController.text.trim()}'
            .trim();

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 100),
            child: Column(
              children: [
                AppTopBar(
                  title: 'Edit Profile',
                  icon: Icons.person_rounded,
                  showNotifications: false,
                  showBackButton: true,
                  gradientColors:
                      Theme.of(context).brightness == Brightness.dark
                          ? [
                              const Color(0xFF1B3A31),
                              const Color(0xFF2F5D50),
                            ]
                          : [
                              const Color(0xFF7FB77E),
                              const Color(0xFF5E9C76),
                            ],
                ),
                const SizedBox(height: 18),
                Container(
                  width: 128,
                  height: 128,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: cardColor,
                    border: Border.all(
                      color: isDarkMode
                          ? Colors.white.withOpacity(0.12)
                          : Colors.white,
                      width: 5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: shadowColor,
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.person,
                    size: 82,
                    color: isDarkMode ? Colors.white70 : secondary,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  fullName.isEmpty ? 'User Profile' : fullName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: mainTextColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                _buildField(
                  controller: firstNameController,
                  hintText: 'First name',
                  icon: Icons.person_outline,
                ),
                _buildField(
                  controller: lastNameController,
                  hintText: 'Last name',
                  icon: Icons.badge_outlined,
                ),
                _buildField(
                  controller: emailController,
                  hintText: 'Email',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 22),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: isSaving ? null : _saveChanges,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      disabledBackgroundColor: primary.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: isSaving
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Save',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const UserBottomNav(currentIndex: 3),
      ),
    );
  }

  Widget _topBar() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: mainTextColor,
              size: 24,
            ),
          ),
        ),
        Text(
          'Edit Profile',
          style: TextStyle(
            color: mainTextColor,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: cardColor.withOpacity(0.96),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: fieldBorderColor),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        cursorColor: secondary,
        style: TextStyle(
          color: mainTextColor,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          icon: Icon(icon, color: isDarkMode ? Colors.white70 : secondary),
          hintText: hintText,
          hintStyle: TextStyle(color: subTextColor),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
