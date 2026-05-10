import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:releaf_app/widgets/app_background.dart';
import 'package:releaf_app/widgets/auth_card.dart';
import 'package:releaf_app/widgets/custom_button.dart';
import 'package:releaf_app/main.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();

  bool isLoading = false;

  String _t(String key, bool isArabic) {
    final en = {
      'title': 'Forgot Password?',
      'subtitle': 'Enter your email to receive a reset link',
      'email': 'Email Address',
      'button': 'Send Reset Link',
      'emptyEmail': 'Please enter your email address',
      'invalidEmail': 'Please enter a valid email address',
      'notRegistered': 'Sorry, this email is not registered',
      'success': 'Password reset link has been sent to your email',
      'error': 'Something went wrong. Please try again',
    };

    final ar = {
      'title': 'نسيت كلمة المرور؟',
      'subtitle': 'أدخل بريدك الإلكتروني لاستلام رابط إعادة التعيين',
      'email': 'البريد الإلكتروني',
      'button': 'إرسال رابط إعادة التعيين',
      'emptyEmail': 'يرجى إدخال البريد الإلكتروني',
      'invalidEmail': 'يرجى إدخال بريد إلكتروني صحيح',
      'notRegistered': 'هذا البريد غير مسجل',
      'success': 'تم إرسال رابط إعادة التعيين إلى بريدك الإلكتروني',
      'error': 'حدث خطأ، يرجى المحاولة مرة أخرى',
    };

    return isArabic ? ar[key]! : en[key]!;
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
  }

  Future<void> _resetPassword(bool isArabic) async {
    final email = emailController.text.trim().toLowerCase();

    if (email.isEmpty) {
      _showMessage(_t('emptyEmail', isArabic));
      return;
    }

    if (!_isValidEmail(email)) {
      _showMessage(_t('invalidEmail', isArabic));
      return;
    }

    setState(() => isLoading = true);

    try {
      final methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

      if (methods.isEmpty) {
        _showMessage(_t('notRegistered', isArabic));
        return;
      }

      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      if (!mounted) return;

      _showMessage(_t('success', isArabic));

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      _showMessage(_t('error', isArabic));
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
    TextInputType keyboardType = TextInputType.text,
    Widget? prefixIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
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
            data: ThemeData.light().copyWith(
              scaffoldBackgroundColor: Colors.transparent,
              iconTheme: const IconThemeData(
                color: Color(0xFF498056),
              ),
              textSelectionTheme: const TextSelectionThemeData(
                cursorColor: Color(0xFF499A64),
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: AppBackground(
                child: SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 20,
                    ),
                    child: Column(
                      children: [
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
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Image.asset(
                          'assets/images/Releaf_logo.png',
                          height: 120,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          _t('title', isArabic),
                          style: const TextStyle(
                            color: Color(0xFF498056),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _t('subtitle', isArabic),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF675F5A),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 35),
                        AuthCard(
                          isDark: false,
                          child: Column(
                            children: [
                              _buildTextField(
                                controller: emailController,
                                hintText: _t('email', isArabic),
                                keyboardType: TextInputType.emailAddress,
                                prefixIcon: const Icon(
                                  Icons.email_outlined,
                                  color: Color(0xFF499A64),
                                ),
                              ),
                              const SizedBox(height: 12),
                              CustomButton(
                                text: _t('button', isArabic),
                                isLoading: isLoading,
                                onTap: () => _resetPassword(isArabic),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
