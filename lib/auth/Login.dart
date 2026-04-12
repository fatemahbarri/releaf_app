import 'package:flutter/material.dart';
import 'package:releaf_app/WelcomeScreen.dart';
import 'package:releaf_app/auth/SignUp.dart';
import 'package:releaf_app/services/firebase_service.dart';
import 'package:releaf_app/widgets/app_background.dart';

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
      if (adminName != null) {
        setState(() {
          adminName = null;
        });
      }
      return;
    }

    try {
      final userData = await _firebaseService.getUserByEmail(trimmedEmail);

      if (!mounted) return;

      setState(() {
        adminName = userData?['name'];
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        adminName = null;
      });
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
        setState(() {
          adminName = name;
        });
      }

      if (widget.isAdminMode) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AdminHomePage(
              adminName: name,
            ),
          ),
        );
      } else {
        // لاحقًا صفحة اليوزر
        // مثال:
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => UserHomePage(userName: name)),
        // );
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
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFD6D6D6)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFD6D6D6)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFF498056),
              width: 1.4,
            ),
          ),
        ),
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              children: [
                const SizedBox(height: 8),
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
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Color(0xFF4A4A4A),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  titleText,
                  style: const TextStyle(
                    color: Color(0xFF498056),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Image.asset(
                    'assets/Releaf_logo.png',
                    height: 150,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  welcomeText,
                  style: const TextStyle(
                    color: Color(0xFF7BA285),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Enter your credentials to continue',
                  style: TextStyle(
                    color: Color(0xFF675F5A),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 28),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7FBEF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      _buildTextField(
                        controller: emailController,
                        hintText: 'Email Address',
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          _checkAdminName(value);
                        },
                      ),
                      _buildTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        obscureText: obscurePassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: Colors.grey[600],
                          ),
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : _signIn,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF499A64),
                            foregroundColor: Colors.white,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: isLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.4,
                                  ),
                                )
                              : const Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
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
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
