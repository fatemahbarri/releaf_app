import 'package:flutter/material.dart';
import 'widgets/app_background.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Column(
            children: [
              // الجزء العلوي الأخضر
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

                      Image.network(
                        "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/sRTqd7cMrP/igfkqvwq_expires_30_days.png",
                        height: 200,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // زر Admin
              _buildButton(
                text: "Login as Admin",
                color: const Color(0xFF499A64),
                textColor: Colors.white,
                onTap: () {
                  print("Admin");
                },
              ),

              const SizedBox(height: 20),

              // زر User
              _buildButton(
                text: "Login as User",
                color: const Color(0xFF8DC149),
                textColor: Colors.black,
                onTap: () {
                  print("User");
                },
              ),

              const SizedBox(height: 20),

              const Text(
                "Don’t have an account? Sign up",
                style: TextStyle(
                  color: Color(0xFF4676AE),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
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
