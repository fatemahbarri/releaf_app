import 'package:flutter/material.dart';
import 'auth/Login.dart';
import '../widgets/releaf_ui.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ReLeafColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Top curved section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [ReLeafColors.primary, ReLeafColors.secondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(60),
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    "WELCOME TO\nReLeaf",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Image.asset(
                    'assets/images/releaf_welcome.png',
                    height: 180,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Buttons section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  // Admin
                  ReLeafButton(
                    text: "Login as Admin",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const LoginPage(isAdminMode: true),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 16),

                  // User
                  ReLeafButton(
                    text: "Login as User",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const LoginPage(isAdminMode: false),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Optional footer text
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                "ReLeaf v1.0.0",
                style: ReLeafTextStyles.subtitle.copyWith(
                  color: const Color(0xFF8A8A8A),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}