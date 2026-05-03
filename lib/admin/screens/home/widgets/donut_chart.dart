import 'dart:math' as math;
import 'package:flutter/material.dart';

class DonutChart extends StatelessWidget {
  final double activePercentage;
  final double blockedPercentage;
  final String centerTopText;
  final String centerBottomText;

  const DonutChart({
    super.key,
    required this.activePercentage,
    required this.blockedPercentage,
    required this.centerTopText,
    required this.centerBottomText,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      width: 120,
      height: 120,
      child: CustomPaint(
        painter: _DonutChartPainter(
          activePercentage: activePercentage,
          blockedPercentage: blockedPercentage,
          activeColor: const Color(0xFF22B573),
          inactiveColor:
              isDark ? Colors.white.withOpacity(0.18) : const Color(0xFFD8D8D8),
          blockedColor: const Color(0xFFE53935),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                centerTopText,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              Text(
                centerBottomText,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white70 : const Color(0xFF777777),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DonutChartPainter extends CustomPainter {
  final double activePercentage;
  final double blockedPercentage;
  final Color activeColor;
  final Color inactiveColor;
  final Color blockedColor;

  _DonutChartPainter({
    required this.activePercentage,
    required this.blockedPercentage,
    required this.activeColor,
    required this.inactiveColor,
    required this.blockedColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 14.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - strokeWidth;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final inactivePaint = Paint()
      ..color = inactiveColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final activePaint = Paint()
      ..color = activeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final blockedPaint = Paint()
      ..color = blockedColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, inactivePaint);

    final active = activePercentage.clamp(0.0, 1.0);
    final blocked = blockedPercentage.clamp(0.0, 1.0 - active);

    final startAngle = -math.pi / 2;
    final activeSweep = 2 * math.pi * active;
    final blockedSweep = 2 * math.pi * blocked;

    canvas.drawArc(rect, startAngle, activeSweep, false, activePaint);
    canvas.drawArc(
      rect,
      startAngle + activeSweep,
      blockedSweep,
      false,
      blockedPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _DonutChartPainter oldDelegate) {
    return oldDelegate.activePercentage != activePercentage ||
        oldDelegate.blockedPercentage != blockedPercentage ||
        oldDelegate.inactiveColor != inactiveColor;
  }
}
