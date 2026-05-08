import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:releaf_app/services/firebase_service.dart';
import 'package:releaf_app/widgets/app_background.dart';
import 'package:releaf_app/widgets/auth_card.dart';
import 'package:releaf_app/widgets/custom_button.dart';
import 'package:releaf_app/auth/Login.dart';
import 'package:releaf_app/main.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
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

class _SignUpState extends State<SignUp> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final FirebaseService _firebaseService = FirebaseService();

  bool isLoading = false;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  String _t(String key, bool isArabic) {
    final en = {
      'title': 'Create Account',
      'subtitle': 'Sign up to get started',
      'fullName': 'Full Name',
      'email': 'Email Address',
      'password': 'Password',
      'confirmPassword': 'Confirm Password',
      'signup': 'Sign up',
      'already': 'Already have an account?',
      'login': 'Log in',
      'fillFields': 'Please fill in all fields',
      'validEmail': 'Please enter a valid email address',
      'passwordMatch': 'Passwords do not match',
      'strongPassword':
          'Password must be at least 8 characters and include uppercase, lowercase, and numbers',
      'verify':
          'Verification email sent. Please check your email before logging in.',
    };

    final ar = {
      'title': 'إنشاء حساب',
      'subtitle': 'أنشئ حسابك للبدء',
      'fullName': 'الاسم الكامل',
      'email': 'البريد الإلكتروني',
      'password': 'كلمة المرور',
      'confirmPassword': 'تأكيد كلمة المرور',
      'signup': 'إنشاء حساب',
      'already': 'لديك حساب بالفعل؟',
      'login': 'تسجيل الدخول',
      'fillFields': 'يرجى تعبئة جميع الحقول',
      'validEmail': 'يرجى إدخال بريد إلكتروني صحيح',
      'passwordMatch': 'كلمتا المرور غير متطابقتين',
      'strongPassword':
          'يجب أن تحتوي كلمة المرور على 8 أحرف على الأقل وتتضمن أحرف كبيرة وصغيرة وأرقام',
      'verify':
          'تم إرسال رابط التحقق إلى بريدك الإلكتروني، يرجى التحقق قبل تسجيل الدخول.',
    };

    return isArabic ? ar[key]! : en[key]!;
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  bool _isStrongPassword(String password) {
    return RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$').hasMatch(password);
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
  }

  Future<void> _signUp(bool isArabic) async {
    final fullName = fullNameController.text.trim();
    final email = emailController.text.trim().toLowerCase();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (fullName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _showMessage(_t('fillFields', isArabic));
      return;
    }

    if (!_isValidEmail(email)) {
      _showMessage(_t('validEmail', isArabic));
      return;
    }

    if (password != confirmPassword) {
      _showMessage(_t('passwordMatch', isArabic));
      return;
    }

    if (!_isStrongPassword(password)) {
      _showMessage(_t('strongPassword', isArabic));
      return;
    }

    setState(() => isLoading = true);

    try {
      await _firebaseService.registerUser(
        name: fullName,
        email: email,
        password: password,
      );

      final user = FirebaseAuth.instance.currentUser;
      await user?.sendEmailVerification();

      if (!mounted) return;

      _showMessage(_t('verify', isArabic));

      fullNameController.clear();
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(isAdminMode: false),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      _showMessage(e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
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
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
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
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFFE0E0E0),
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
    return ValueListenableBuilder<Locale>(
      valueListenable: localeNotifier,
      builder: (context, locale, _) {
        final isArabic = locale.languageCode == 'ar';

        return Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: Theme(
            data: ThemeData.light(),
            child: Scaffold(
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 20,
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 8),
                            Align(
                              alignment: isArabic
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: Color(0xFF2A2A2A),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Image.asset(
                              'assets/images/Releaf_logo.png',
                              height: 120,
                            ),
                            const SizedBox(height: 14),
                            Text(
                              _t('title', isArabic),
                              style: const TextStyle(
                                color: Color(0xFF498056),
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              _t('subtitle', isArabic),
                              style: const TextStyle(
                                color: Color(0xFF2A2A2A),
                              ),
                            ),
                            const SizedBox(height: 28),
                            AuthCard(
                              isDark: false,
                              child: Column(
                                children: [
                                  _buildTextField(
                                    controller: fullNameController,
                                    hintText: _t('fullName', isArabic),
                                    prefixIcon: const Icon(
                                      Icons.person_outline,
                                      color: Color(0xFF499A64),
                                    ),
                                  ),
                                  _buildTextField(
                                    controller: emailController,
                                    hintText: _t('email', isArabic),
                                    keyboardType: TextInputType.emailAddress,
                                    prefixIcon: const Icon(
                                      Icons.email_outlined,
                                      color: Color(0xFF499A64),
                                    ),
                                  ),
                                  _buildTextField(
                                    controller: passwordController,
                                    hintText: _t('password', isArabic),
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
                                        color: const Color(0xFF675F5A),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          obscurePassword = !obscurePassword;
                                        });
                                      },
                                    ),
                                  ),
                                  _buildTextField(
                                    controller: confirmPasswordController,
                                    hintText: _t('confirmPassword', isArabic),
                                    obscureText: obscureConfirmPassword,
                                    prefixIcon: const Icon(
                                      Icons.lock_outline,
                                      color: Color(0xFF499A64),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        obscureConfirmPassword
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: const Color(0xFF675F5A),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          obscureConfirmPassword =
                                              !obscureConfirmPassword;
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  CustomButton(
                                    text: _t('signup', isArabic),
                                    isLoading: isLoading,
                                    onTap: () => _signUp(isArabic),
                                  ),
                                  const SizedBox(height: 12),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: RichText(
                                      text: TextSpan(
                                        text: '${_t('already', isArabic)} ',
                                        style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 70, 68, 68),
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: _t('login', isArabic),
                                            style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 19, 72, 115),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
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
            ),
          ),
        );
      },
    );
  }
}
