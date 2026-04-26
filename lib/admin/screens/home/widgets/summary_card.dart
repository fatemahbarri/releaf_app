import 'package:flutter/material.dart';
import 'donut_chart.dart';

class SummaryCard extends StatelessWidget {
  final int totalUsers;
  final int activeUsers;
  final int inactiveUsers;

  const SummaryCard({
    super.key,
    required this.totalUsers,
    required this.activeUsers,
    required this.inactiveUsers,
  });

  @override
  Widget build(BuildContext context) {
    final double activePercentage =
        totalUsers == 0 ? 0 : activeUsers / totalUsers;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.75),
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ Donut fixed size (no stretching)
          SizedBox(
            width: 110,
            height: 110,
            child: DonutChart(
              percentage: activePercentage,
              centerTopText: '$totalUsers',
              centerBottomText: 'Users',
            ),
          ),

          const SizedBox(width: 18),

          // ✅ Flexible instead of Expanded (prevents stretching)
          Flexible(
            fit: FlexFit.loose,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // 🔥 important
              children: [
                const Text(
                  'Users Activity',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'A quick overview of active and inactive users.',
                  style: TextStyle(
                    fontSize: 13.5,
                    height: 1.4,
                    color: Color(0xFF6B6B6B),
                  ),
                ),
                const SizedBox(height: 14),
                _LegendItem(
                  color: Color(0xFF22B573),
                  label: 'Active Users',
                  value: activeUsers.toString(),
                ),
                const SizedBox(height: 8),
                _LegendItem(
                  color: Color(0xFFD8D8D8),
                  label: 'Inactive Users',
                  value: inactiveUsers.toString(),
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

  const _LegendItem({
    required this.color,
    required this.label,
    required this.value,
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
            style: const TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.w600,
              color: Color(0xFF4F4F4F),
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
