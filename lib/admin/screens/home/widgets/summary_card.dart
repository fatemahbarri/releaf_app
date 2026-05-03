import 'package:flutter/material.dart';
import 'donut_chart.dart';

class SummaryCard extends StatelessWidget {
  final int totalUsers;
  final int activeUsers;
  final int inactiveUsers;
  final int blockedUsers;

  const SummaryCard({
    super.key,
    required this.totalUsers,
    required this.activeUsers,
    required this.inactiveUsers,
    required this.blockedUsers,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final double activePercentage =
        totalUsers == 0 ? 0 : activeUsers / totalUsers;

    final double blockedPercentage =
        totalUsers == 0 ? 0 : blockedUsers / totalUsers;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF1F2D28).withOpacity(0.92)
            : Colors.white.withOpacity(0.75),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.transparent,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.25 : 0.07),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            height: 110,
            child: DonutChart(
              activePercentage: activePercentage,
              blockedPercentage: blockedPercentage,
              centerTopText: '$totalUsers',
              centerBottomText: 'Users',
            ),
          ),
          const SizedBox(width: 18),
          Flexible(
            fit: FlexFit.loose,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Users Activity',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'A quick overview of active, inactive and blocked users.',
                  style: TextStyle(
                    fontSize: 13.5,
                    height: 1.4,
                    color: isDark ? Colors.white70 : const Color(0xFF6B6B6B),
                  ),
                ),
                const SizedBox(height: 14),
                _LegendItem(
                  color: const Color(0xFF22B573),
                  label: 'Active Users',
                  value: activeUsers.toString(),
                  isDark: isDark,
                ),
                const SizedBox(height: 8),
                _LegendItem(
                  color: isDark ? Colors.white24 : const Color(0xFFD8D8D8),
                  label: 'Inactive Users',
                  value: inactiveUsers.toString(),
                  isDark: isDark,
                ),
                const SizedBox(height: 8),
                _LegendItem(
                  color: const Color(0xFFE53935),
                  label: 'Blocked Users',
                  value: blockedUsers.toString(),
                  isDark: isDark,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final String value;
  final bool isDark;

  const _LegendItem({
    required this.color,
    required this.label,
    required this.value,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 13,
          height: 13,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white70 : const Color(0xFF4F4F4F),
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
      ],
    );
  }
}
