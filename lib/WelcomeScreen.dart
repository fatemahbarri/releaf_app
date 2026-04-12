import 'package:flutter/material.dart';
import 'widgets/app_background.dart';
import 'auth/Login.dart';
import 'auth/SignUp.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFF8DC149),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(140),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x40000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "WELCOME TO\nReLeaf",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),

                      /// 🔥 صورة الويلكم الجديدة
                      Image.asset(
                        'assets/releaf_welcome.png',
                        height: 200,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              /// 🔥 زر الأدمن
              _buildButton(
                text: "Login as Admin",
                color: const Color(0xFF499A64),
                textColor: Colors.white,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(
                        isAdminMode: true,
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              /// 🔥 زر اليوزر
              _buildButton(
                text: "Login as User",
                color: const Color(0xFF8DC149),
                textColor: Colors.black,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(
                        isAdminMode: false,
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              /// 🔥 رابط التسجيل
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
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton({
    required String text,
    required Color color,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(40),
          boxShadow: const [
            BoxShadow(
              color: Color(0x40000000),
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
