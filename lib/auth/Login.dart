import 'package:flutter/material.dart';
import 'package:releaf_app/WelcomeScreen.dart';
import 'package:releaf_app/auth/SignUp.dart';
import 'package:releaf_app/services/firebase_service.dart';
import 'package:releaf_app/widgets/app_background.dart';
import 'package:releaf_app/widgets/auth_card.dart';
import 'package:releaf_app/widgets/custom_button.dart';

import '../admin/AdminHomePage.dart';

class LoginPage extends StatefulWidget {
  final bool isAdminMode;

  const LoginPage({
    super.key,
    required this.isAdminMode,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, size.height - 60);

    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 60,
    );

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseService _firebaseService = FirebaseService();

  bool isLoading = false;
  bool obscurePassword = true;
  String? adminName;

  String get titleText {
    return widget.isAdminMode ? 'Admin Sign In' : 'User Sign In';
  }

  String get welcomeText {
    if (widget.isAdminMode && adminName != null && adminName!.isNotEmpty) {
      return 'Welcome $adminName';
    }
    return 'Welcome Back';
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _checkAdminName(String email) async {
    final trimmedEmail = email.trim().toLowerCase();

    if (!widget.isAdminMode || !trimmedEmail.endsWith('@releaf.com')) {
      setState(() => adminName = null);
      return;
    }

    try {
      final userData = await _firebaseService.getUserByEmail(trimmedEmail);
      if (!mounted) return;
      setState(() => adminName = userData?['name']);
    } catch (_) {
      if (!mounted) return;
      setState(() => adminName = null);
    }
  }

  Future<void> _signIn() async {
    final email = emailController.text.trim().toLowerCase();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showMessage('Please fill in all fields');
      return;
    }

    if (!_isValidEmail(email)) {
      _showMessage('Please enter a valid email address');
      return;
    }

    final bool isAdminEmail = email.endsWith('@releaf.com');

    if (widget.isAdminMode && !isAdminEmail) {
      _showMessage('This page is for admin email only');
      return;
    }

    if (!widget.isAdminMode && isAdminEmail) {
      _showMessage('Admin accounts must log in from Admin Login');
      return;
    }

    setState(() => isLoading = true);

    try {
      final userData = await _firebaseService.loginUser(
        email: email,
        password: password,
      );

      if (!mounted) return;

      final role = (userData['role'] ?? '').toString().toLowerCase();
      final name = (userData['name'] ?? '').toString();

      if (widget.isAdminMode && role != 'admin') {
        _showMessage('This account is not registered as admin');
        return;
      }

      if (!widget.isAdminMode && role == 'admin') {
        _showMessage('This account is admin, please use Admin Login');
        return;
      }

      if (widget.isAdminMode) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AdminHomePage(adminName: name),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      _showMessage(e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffixIcon,
    Widget? prefixIcon,
    void Function(String)? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color(0xFF8A8A8A),
          ),
          filled: true,
          fillColor: const Color(0xFFFAFAFA),
          prefixIcon: prefixIcon,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFFE0E0E0),
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFFE0E0E0),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFF499A64),
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 280,
              width: double.infinity,
              child: ClipPath(
                clipper: BottomWaveClipper(),
                child: Container(
                  color: const Color(0xFFB7D98A),
                ),
              ),
            ),
          ),
          AppBackground(
            child: SafeArea(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WelcomeScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      titleText,
                      style: const TextStyle(
                        color: Color(0xFF498056),
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Image.asset(
                      'assets/images/Releaf_logo.png',
                      height: 130,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      welcomeText,
                      style: const TextStyle(
                        color: Color(0xFF7BA285),
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Enter your credentials to continue',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    AuthCard(
                      child: Column(
                        children: [
                          _buildTextField(
                            controller: emailController,
                            hintText: 'Email Address',
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: const Icon(
                              Icons.email_outlined,
                              color: Color(0xFF499A64),
                            ),
                            onChanged: (v) => _checkAdminName(v),
                          ),
                          _buildTextField(
                            controller: passwordController,
                            hintText: 'Password',
                            obscureText: obscurePassword,
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              color: Color(0xFF499A64),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  obscurePassword = !obscurePassword;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          CustomButton(
                            text: 'Login',
                            isLoading: isLoading,
                            onTap: _signIn,
                          ),
                          if (!widget.isAdminMode) ...[
                            const SizedBox(height: 12),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignUp(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Don’t have an account? Sign up",
                                style: TextStyle(
                                  color: Color(0xFF4676AE),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
