import 'dart:async';
import 'package:flutter/material.dart';
import 'WelcomeScreen.dart';
import 'widgets/app_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 320,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFF8DC149),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(140),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x40000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 220,
                      height: 220,
                      child: Image.network(
                        "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/sRTqd7cMrP/ndwwana1_expires_30_days.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'ReLeaf',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
