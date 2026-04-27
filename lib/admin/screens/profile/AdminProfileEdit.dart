import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../widgets/admin_background.dart';

class AdminProfileEdit extends StatefulWidget {
  final String currentName;
  final String currentEmail;
  final String currentPassword;

  const AdminProfileEdit({
    super.key,
    required this.currentName,
    required this.currentEmail,
    required this.currentPassword,
  });

  @override
  State<AdminProfileEdit> createState() => _AdminProfileEditState();
}

class _AdminProfileEditState extends State<AdminProfileEdit> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  bool _isLoading = false;

  static const Color primary = Color(0xFF7FB77E);
  static const Color secondary = Color(0xFF5E9C76);
  static const Color background = Color(0xFFF7FBF2);
  static const Color lightGreen = Color(0xFFEAF6E3);
  static const Color border = Color(0xFFDCE8D7);
  static const Color textDark = Color(0xFF2F5D50);
  static const Color textMedium = Color(0xFF4E6A57);

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName);
    _emailController = TextEditingController(text: widget.currentEmail);
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  Future<void> _saveChanges() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (name.isEmpty || email.isEmpty) {
      _showMessage('Please fill the required fields');
      return;
    }

    if (password.isNotEmpty || confirmPassword.isNotEmpty) {
      if (password != confirmPassword) {
        _showMessage('Passwords do not match');
        return;
      }
    }

    setState(() => _isLoading = true);

    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception('User not logged in');
      }

      await FirebaseFirestore.instance
          .collection('admins')
          .doc(user.uid)
          .update({
        'name': name,
        'email': email,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      if (email != user.email) {
        await user.updateEmail(email);
      }

      if (password.isNotEmpty) {
        await user.updatePassword(password);
      }

      if (!mounted) return;

      Navigator.pop(context, {
        'name': name,
        'email': email,
        'password': password.isNotEmpty ? password : widget.currentPassword,
      });
    } catch (_) {
      _showMessage('Failed to update profile');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _topBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [primary, secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(24),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          ),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.edit_outlined,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Edit Profile',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    bool obscureText = false,
    IconData? icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: border),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(
          color: textDark,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFF8A9A8C)),
          prefixIcon: icon != null ? Icon(icon, color: textMedium) : null,
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        ),
      ),
    );
  }

  Widget _saveButton() {
    return GestureDetector(
      onTap: _isLoading ? null : _saveChanges,
      child: Opacity(
        opacity: _isLoading ? 0.6 : 1,
        child: Container(
          width: double.infinity,
          height: 56,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [primary, secondary],
            ),
            borderRadius: BorderRadius.circular(28),
          ),
          child: _isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text(
                  'Save Changes',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: AdminBackground(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _topBar(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: lightGreen,
                          border: Border.all(color: primary, width: 3),
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 80,
                          color: textDark,
                        ),
                      ),
                      const SizedBox(height: 28),
                      _buildInputField(
                        controller: _nameController,
                        hint: 'Name',
                        icon: Icons.person_outline,
                      ),
                      _buildInputField(
                        controller: _emailController,
                        hint: 'Email',
                        icon: Icons.email_outlined,
                      ),
                      _buildInputField(
                        controller: _passwordController,
                        hint: 'New Password',
                        obscureText: true,
                        icon: Icons.lock_outline,
                      ),
                      _buildInputField(
                        controller: _confirmPasswordController,
                        hint: 'Confirm Password',
                        obscureText: true,
                        icon: Icons.lock_reset_outlined,
                      ),
                      const SizedBox(height: 16),
                      _saveButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}