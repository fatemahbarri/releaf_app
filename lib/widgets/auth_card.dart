import 'package:flutter/material.dart';

class AuthCard extends StatelessWidget {
  final Widget child;
  final bool? isDark;

  const AuthCard({
    super.key,
    required this.child,
    this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final bool dark = isDark ?? Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: dark
            ? const Color(0xFF18221E) // 🔥 أغمق شوي
            : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: dark
              ? const Color(0xFF2F5D50) // نفس لون الثيم
              : const Color(0xFFEAEAEA),
        ),
        boxShadow: [
          BoxShadow(
            color: dark
                ? Colors.black.withOpacity(0.45) // 🔥 أوضح في الدارك
                : Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}
