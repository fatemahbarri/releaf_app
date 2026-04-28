import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/admin_theme.dart';

class AdminBackground extends StatelessWidget {
  final Widget child;

  const AdminBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AdminTheme.background,
            AdminTheme.backgroundDark,
          ],
        ),
      ),
      child: Stack(
        children: [
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
                  'assets/images/waves/Wave2.svg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
