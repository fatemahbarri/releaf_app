import 'package:flutter/material.dart';
import '..//theme/admin_theme.dart';

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
      child: SafeArea(
        child: child,
      ),
    );
  }
}
