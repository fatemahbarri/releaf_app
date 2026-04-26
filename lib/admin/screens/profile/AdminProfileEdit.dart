import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../widgets/admin_background.dart';
import '../../widgets/admin_header.dart';
import '../../theme/admin_theme.dart';

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
    } on FirebaseAuthException catch (e) {
      String message = 'Failed to update profile';

      if (e.code == 'requires-recent-login') {
        message = 'Please log in again before changing email or password';
      } else if (e.code == 'email-already-in-use') {
        message = 'This email is already in use';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email address';
      } else if (e.code == 'weak-password') {
        message = 'Password is too weak';
      }

      _showMessage(message);
    } catch (_) {
      _showMessage('Failed to update profile');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    bool obscureText = false,
    IconData? icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: AdminTheme.card,
        border: Border.all(
          color: AdminTheme.border,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(
          color: AdminTheme.textDark,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: Color(0xFF8A8A8A),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: icon == null
              ? null
              : Icon(
                  icon,
                  color: AdminTheme.primary,
                ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 18,
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
      body: AdminBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 24, 22, 24),
          child: Column(
            children: [
              const AdminHeader(
                title: 'Edit Profile',
                showBack: true,
              ),
              const SizedBox(height: 28),
              Container(
                width: 155,
                height: 155,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AdminTheme.card,
                  border: Border.all(
                    color: AdminTheme.primary,
                    width: 4,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x22000000),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.person,
                  size: 105,
                  color: AdminTheme.primary,
                ),
              ),
              const SizedBox(height: 44),
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
                hint: 'Confirm New Password',
                obscureText: true,
                icon: Icons.lock_reset_outlined,
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: 230,
                height: 60,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveChanges,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AdminTheme.primary,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(34),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Save Changes',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
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
