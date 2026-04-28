import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBackground extends StatelessWidget {
  final Widget child;

  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background color
          Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color(0xFFF3FFE2),
          ),

          // Wave at bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 500,
            child: Opacity(
              opacity: 0.8,
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationX(3.1416),
                child: SvgPicture.asset(
                  'assets/images/waves/Wave1.svg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Page content
          SafeArea(
            child: child,
          ),
        ],
      ),
    );
  }
}
