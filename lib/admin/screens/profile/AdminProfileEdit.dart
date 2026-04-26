import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill the required fields')),
      );
      return;
    }

    if (password.isNotEmpty || confirmPassword.isNotEmpty) {
      if (password != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Passwords do not match')),
        );
        return;
      }
    }

    setState(() {
      _isLoading = true;
    });

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

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update profile')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    bool obscureText = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 34),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        border: Border.all(
          color: const Color(0xFFC4C4C4),
          width: 1,
        ),
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
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: Color(0xFF9B9B9B),
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24,
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
      backgroundColor: const Color(0xFFF3FFE2),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(22, 24, 22, 24),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed:
                            _isLoading ? null : () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Color(0xFF675F5A),
                          size: 34,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 170,
                      height: 170,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFC7D3C6),
                        border: Border.all(
                          color: const Color(0xFF446B54),
                          width: 5,
                        ),
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 120,
                        color: Color(0xFF446B54),
                      ),
                    ),
                    const SizedBox(height: 70),
                    _buildInputField(
                      controller: _nameController,
                      hint: 'Name',
                    ),
                    _buildInputField(
                      controller: _emailController,
                      hint: 'Email',
                    ),
                    _buildInputField(
                      controller: _passwordController,
                      hint: 'Password',
                      obscureText: true,
                    ),
                    _buildInputField(
                      controller: _confirmPasswordController,
                      hint: 'Confirm Password',
                      obscureText: true,
                    ),
                    const SizedBox(height: 36),
                    SizedBox(
                      width: 230,
                      height: 68,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _saveChanges,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFB8D67D),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(34),
                          ),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator()
                            : const Text(
                                'Done',
                                style: TextStyle(
                                  color: Color(0xFF5B5554),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
