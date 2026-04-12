import 'dart:async';
import 'package:flutter/material.dart';
import 'WelcomeScreen.dart';
import 'widgets/app_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );

    _scale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0.85,
          end: 1.05,
        ).chain(CurveTween(curve: Curves.easeOutBack)),
        weight: 60,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.05,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 40,
      ),
    ]).animate(_controller);

    _controller.forward();

    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Stack(
            children: [
              // الموجة السفلية
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

              // اللوقو فقط
              Center(
                child: AnimatedBuilder(
                  animation: _scale,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scale.value,
                      child: child,
                    );
                  },
                  child: Image.asset(
                    'assets/Releaf_logo.png',
                    width: 180,
                    height: 180,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(0, size.height * 0.28);

    path.quadraticBezierTo(
      size.width * 0.15,
      size.height * 0.02,
      size.width * 0.38,
      size.height * 0.18,
    );

    path.quadraticBezierTo(
      size.width * 0.58,
      size.height * 0.34,
      size.width * 0.78,
      size.height * 0.20,
    );

    path.quadraticBezierTo(
      size.width * 0.90,
      size.height * 0.12,
      size.width,
      size.height * 0.24,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
