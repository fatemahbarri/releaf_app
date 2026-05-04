import 'package:flutter/material.dart';
import 'package:releaf_app/WelcomeScreen.dart';
import 'package:releaf_app/auth/SignUp.dart';
import 'package:releaf_app/auth/ForgotPasswordPage.dart';
import 'package:releaf_app/user/Home/HomePageUser.dart';
import 'package:releaf_app/services/firebase_service.dart';
import 'package:releaf_app/widgets/app_background.dart';
import 'package:releaf_app/widgets/auth_card.dart';
import 'package:releaf_app/widgets/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:releaf_app/main.dart';
import 'package:releaf_app/admin/widgets/admin_background.dart';
import '../admin/screens/home/AdminHomePage.dart';

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
    final path = Path();

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
  bool rememberMe = false;
  String? adminName;

  String get titleText {
    return widget.isAdminMode ? 'Admin Login' : 'User Login';
  }

  bool get isDark => Theme.of(context).brightness == Brightness.dark;
  Color get titleColor =>
      isDark ? const Color(0xFF8BC99B) : const Color(0xFF498056);

  Color get textColor =>
      isDark ? const Color(0xFFE9EFEA) : const Color(0xFF2A2A2A);

  Color get subTextColor =>
      isDark ? const Color(0xFFB9C3BC) : const Color(0xFF675F5A);

  Color get fieldFillColor =>
      isDark ? const Color(0xFF2A332D) : const Color(0xFFFAFAFA);

  Color get fieldBorderColor =>
      isDark ? const Color(0xFF4A5A4F) : const Color(0xFFE0E0E0);

  Color get primaryGreen =>
      isDark ? const Color(0xFF7FC58E) : const Color(0xFF499A64);

  Color get linkColor =>
      isDark ? const Color(0xFF9CBFE6) : const Color(0xFF4676AE);

  @override
  void initState() {
    super.initState();
    _loadRememberedEmail();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> openWhatsAppSupport() async {
    final Uri url = Uri.parse(
      'https://wa.me/966555229836?text=Hello%20ReLeaf%20Support,%20my%20account%20is%20blocked.',
    );

    await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
  }

  Future<void> _loadRememberedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final key =
        widget.isAdminMode ? 'remembered_admin_email' : 'remembered_user_email';
    final savedEmail = prefs.getString(key);

    if (savedEmail != null && savedEmail.isNotEmpty) {
      setState(() {
        emailController.text = savedEmail;
        rememberMe = true;
      });

      await _checkAdminName(savedEmail);
    }
  }

  Future<void> _saveRememberedEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final key =
        widget.isAdminMode ? 'remembered_admin_email' : 'remembered_user_email';

    if (rememberMe) {
      await prefs.setString(key, email);
    } else {
      await prefs.remove(key);
    }
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

      final status =
          (userData['accountStatus'] ?? 'active').toString().toLowerCase();

      if (status == 'blocked') {
        await FirebaseAuth.instance.signOut();
        if (!mounted) return;

        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Account Blocked'),
            content: const Text(
              'Your account has been blocked.\nPlease contact support via WhatsApp.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: openWhatsAppSupport,
                child: const Text('WhatsApp'),
              ),
            ],
          ),
        );

        return;
      }

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

      await _saveRememberedEmail(email);

      if (widget.isAdminMode) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => AdminHomePage(adminName: name),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const HomePageUser(),
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
        cursorColor: primaryGreen,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: isDark ? const Color(0xFF9DA9A1) : const Color(0xFF8A8A8A),
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
          filled: true,
          fillColor: fieldFillColor,
          prefixIcon: prefixIcon,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: fieldBorderColor,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: fieldBorderColor,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: primaryGreen,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRememberMe() {
    return Align(
      alignment: Alignment.centerLeft,
      child: InkWell(
        onTap: () {
          setState(() {
            rememberMe = !rememberMe;
          });
        },
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: rememberMe ? primaryGreen : Colors.transparent,
                  border: Border.all(
                    color: rememberMe
                        ? primaryGreen
                        : isDark
                            ? const Color(0xFF8A958D)
                            : const Color(0xFFBDBDBD),
                    width: 2,
                  ),
                ),
                child: rememberMe
                    ? const Icon(
                        Icons.check,
                        size: 14,
                        color: Colors.white,
                      )
                    : null,
              ),
              const SizedBox(width: 10),
              Text(
                'Remember me',
                style: TextStyle(
                  color: subTextColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget _buildBackground({required Widget child}) {
    if (widget.isAdminMode) {
      return AdminBackground(child: child);
    }

    return AppBackground(child: child);
  }

  Widget _buildLoginContent() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const WelcomeScreen(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 22,
                  color: textColor,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              titleText,
              style: TextStyle(
                color: titleColor,
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 18),
            Image.asset(
              'assets/images/Releaf_logo.png',
              height: widget.isAdminMode ? 130 : 125,
            ),
            const SizedBox(height: 70),
            AuthCard(
              child: Column(
                children: [
                  _buildTextField(
                    controller: emailController,
                    hintText: 'Email Address',
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: primaryGreen,
                    ),
                    onChanged: (value) => _checkAdminName(value),
                  ),
                  _buildTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: obscurePassword,
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: primaryGreen,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: subTextColor,
                      ),
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 2),
                  _buildRememberMe(),
                  const SizedBox(height: 18),
                  CustomButton(
                    text: 'Login',
                    isLoading: isLoading,
                    onTap: _signIn,
                  ),
                  if (!widget.isAdminMode)
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ForgotPasswordPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: linkColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  if (!widget.isAdminMode) ...[
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SignUp(),
                          ),
                        );
                      },
                      child: Text(
                        'Don’t have an account? Sign up',
                        style: TextStyle(
                          color: linkColor,
                          fontWeight: FontWeight.w600,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        scaffoldBackgroundColor:
            isDark ? const Color(0xFF1F2A23) : Colors.white,
        textTheme: Theme.of(context).textTheme.apply(),
      ),
      child: Scaffold(
        body: Stack(
          children: [
            if (!widget.isAdminMode)
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 260,
                  width: double.infinity,
                  child: ClipPath(
                    clipper: BottomWaveClipper(),
                    child: Container(
                      color: isDark
                          ? const Color(0xFF3E5A42)
                          : const Color(0xFFB7D98A),
                    ),
                  ),
                ),
              ),
            _buildBackground(
              child: _buildLoginContent(),
            ),
          ],
        ),
      ),
    );
  }
}
