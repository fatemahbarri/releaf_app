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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark
              ? [
                  const Color(0xFF0B1410), // 🔥 أغمق فوق
                  const Color(0xFF050A08), // 🔥 أغمق تحت
                ]
              : [
                  AdminTheme.background,
                  AdminTheme.backgroundDark,
                ],
        ),
      ),
      child: Stack(
        children: [
          /// ✨ طبقة زيادة تعطي عمق (اختياري لكن جميلة)
          if (isDark)
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.2),
                    Colors.transparent,
                    Colors.black.withOpacity(0.3),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),

          /// 🌊 الويفز
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 500,
            child: Opacity(
              opacity: isDark ? 0.45 : 0.8, // 👈 وضوح متوازن
              child: ColorFiltered(
                colorFilter: isDark
                    ? const ColorFilter.mode(
                        Colors.black54,
                        BlendMode.darken,
                      )
                    : const ColorFilter.mode(
                        Colors.transparent,
                        BlendMode.dst,
                      ),
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
          ),

          child,
        ],
      ),
    );
  }
}
