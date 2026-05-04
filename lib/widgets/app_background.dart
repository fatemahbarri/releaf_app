import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBackground extends StatelessWidget {
  final Widget child;

  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      children: [
        // Background color
        Container(
          width: double.infinity,
          height: double.infinity,
          color: isDark
              ? const Color(0xFF0F1713) // Dark background
              : const Color(0xFFF3FFE2), // Light background
        ),

        // Wave at bottom
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 500,
          child: Opacity(
            opacity: isDark ? 0.35 : 0.8,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationX(3.1416),
              child: ColorFiltered(
                colorFilter: isDark
                    ? ColorFilter.mode(
                        Colors.black.withOpacity(0.25),
                        BlendMode.darken,
                      )
                    : const ColorFilter.mode(
                        Colors.transparent,
                        BlendMode.multiply,
                      ),
                child: SvgPicture.asset(
                  'assets/images/waves/Wave1.svg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),

        // Page content
        SafeArea(
          bottom: false,
          child: child,
        ),
      ],
    );
  }
}
