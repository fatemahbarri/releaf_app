import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/app_background.dart';
import 'AdminBar.dart';
import 'AdminUserManagment.dart';
import 'AdminBinManagment.dart';

class AdminHomePage extends StatefulWidget {
  final String adminName;

  const AdminHomePage({
    super.key,
    required this.adminName,
  });

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  int totalUsers = 0;
  int activeUsers = 0;
  int totalBins = 0;
  int reportedIssues = 0;
  int newNotifications = 0;

  String displayedAdminName = 'Admin';

  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    displayedAdminName = widget.adminName;
    fetchDashboardStats();
  }

  Future<void> fetchDashboardStats() async {
    try {
      final currentUser = _auth.currentUser;

      final futures = <Future>[
        _firestore.collection('users').get(),
        _firestore
            .collection('users')
            .where('accountStatus', isEqualTo: 'active')
            .get(),
        _firestore.collection('bins').get(),
        _firestore.collection('reports').get(),
        _firestore
            .collection('reports')
            .where('isRead', isEqualTo: false)
            .get(),
      ];

      DocumentSnapshot? currentAdminDoc;

      if (currentUser != null) {
        currentAdminDoc =
            await _firestore.collection('users').doc(currentUser.uid).get();
      }

      final results = await Future.wait(futures);

      if (!mounted) return;

      final totalUsersSnapshot = results[0] as QuerySnapshot;
      final activeUsersSnapshot = results[1] as QuerySnapshot;
      final totalBinsSnapshot = results[2] as QuerySnapshot;
      final reportedIssuesSnapshot = results[3] as QuerySnapshot;
      final newNotificationsSnapshot = results[4] as QuerySnapshot;

      String resolvedAdminName = widget.adminName;

      if (currentAdminDoc != null && currentAdminDoc.exists) {
        final adminData = currentAdminDoc.data() as Map<String, dynamic>?;
        final firestoreName = adminData?['name']?.toString().trim();

        if (firestoreName != null && firestoreName.isNotEmpty) {
          resolvedAdminName = firestoreName;
        }
      }

      setState(() {
        displayedAdminName = resolvedAdminName;
        totalUsers = totalUsersSnapshot.docs.length;
        activeUsers = activeUsersSnapshot.docs.length;
        totalBins = totalBinsSnapshot.docs.length;
        reportedIssues = reportedIssuesSnapshot.docs.length;
        newNotifications = newNotificationsSnapshot.docs.length;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  int get inactiveUsers {
    final value = totalUsers - activeUsers;
    return value < 0 ? 0 : value;
  }

  void _goToUserManagement(String filter) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdminUserManagment(initialFilter: filter),
      ),
    );
  }

  void _goToBinManagement() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AdminBinManagment(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 10),
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : errorMessage != null
                    ? Center(
                        child: Text(
                          errorMessage!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTopHeader(),
                            const SizedBox(height: 28),
                            Center(
                              child: Text(
                                'Welcome Back, $displayedAdminName !',
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Center(
                              child: Text(
                                'Admin Dashboard Overview',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF6B6B6B),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(height: 34),
                            const Padding(
                              padding: EdgeInsets.only(left: 4),
                              child: Text(
                                'Dashboard',
                                style: TextStyle(
                                  fontSize: 29,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF675F5A),
                                ),
                              ),
                            ),
                            const SizedBox(height: 18),
                            _DashboardSummaryCard(
                              totalUsers: totalUsers,
                              activeUsers: activeUsers,
                              inactiveUsers: inactiveUsers,
                            ),
                            const SizedBox(height: 24),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () =>
                                        _goToUserManagement('All Users'),
                                    child: _DashboardCard(
                                      title: 'Total Users',
                                      value: totalUsers.toString(),
                                      icon: Icons.people_alt_rounded,
                                      startColor: const Color(0xFF22B573),
                                      endColor: const Color(0xFF11995D),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => _goToUserManagement('Active'),
                                    child: _DashboardCard(
                                      title: 'Active Users',
                                      value: activeUsers.toString(),
                                      icon: Icons.person_add_alt_1_rounded,
                                      startColor: const Color(0xFF3BB273),
                                      endColor: const Color(0xFF238B53),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: _goToBinManagement,
                                    child: _DashboardCard(
                                      title: 'Total Bins',
                                      value: totalBins.toString(),
                                      icon: Icons.delete_outline_rounded,
                                      startColor: const Color(0xFF4DA8DA),
                                      endColor: const Color(0xFF2E86C1),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: _DashboardCard(
                                    title: 'Reported Issues',
                                    value: reportedIssues.toString(),
                                    icon: Icons.report_problem_outlined,
                                    startColor: const Color(0xFFFF8A65),
                                    endColor: const Color(0xFFF4511E),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
          ),
        ),
      ),
      bottomNavigationBar: const AdminBar(selectedIndex: 0),
    );
  }

  Widget _buildTopHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CircleAvatar(
          radius: 24,
          backgroundColor: Color(0xFFD9EFD7),
          child: Icon(
            Icons.admin_panel_settings_rounded,
            color: Color(0xFF2E8B57),
            size: 28,
          ),
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.70),
                borderRadius: BorderRadius.circular(18),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x14000000),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.notifications_none_rounded,
                size: 28,
                color: Color(0xFF2E8B57),
              ),
            ),
            if (newNotifications > 0)
              Positioned(
                right: -4,
                top: -4,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 3,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 20,
                    minHeight: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                  child: Text(
                    newNotifications > 99 ? '99+' : '$newNotifications',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _DashboardSummaryCard extends StatelessWidget {
  final int totalUsers;
  final int activeUsers;
  final int inactiveUsers;

  const _DashboardSummaryCard({
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
        children: [
          _DonutChart(
            percentage: activePercentage,
            centerTopText: '$totalUsers',
            centerBottomText: 'Users',
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  color: const Color(0xFF22B573),
                  label: 'Active Users',
                  value: activeUsers.toString(),
                ),
                const SizedBox(height: 8),
                _LegendItem(
                  color: const Color(0xFFD8D8D8),
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

class _DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color startColor;
  final Color endColor;

  const _DashboardCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.startColor,
    required this.endColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [startColor, endColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1F000000),
            blurRadius: 14,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.22),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 22,
              ),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DonutChart extends StatelessWidget {
  final double percentage;
  final String centerTopText;
  final String centerBottomText;

  const _DonutChart({
    required this.percentage,
    required this.centerTopText,
    required this.centerBottomText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 120,
      child: CustomPaint(
        painter: _DonutChartPainter(
          percentage: percentage,
          activeColor: const Color(0xFF22B573),
          inactiveColor: const Color(0xFFD8D8D8),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                centerTopText,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
              ),
              Text(
                centerBottomText,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF777777),
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
  final double percentage;
  final Color activeColor;
  final Color inactiveColor;

  _DonutChartPainter({
    required this.percentage,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 14.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - strokeWidth;

    final backgroundPaint = Paint()
      ..color = inactiveColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final activePaint = Paint()
      ..color = activeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    final startAngle = -math.pi / 2;
    final sweepAngle = 2 * math.pi * percentage.clamp(0.0, 1.0);
    final rect = Rect.fromCircle(center: center, radius: radius);

    canvas.drawArc(rect, startAngle, sweepAngle, false, activePaint);
  }

  @override
  bool shouldRepaint(covariant _DonutChartPainter oldDelegate) {
    return oldDelegate.percentage != percentage ||
        oldDelegate.activeColor != activeColor ||
        oldDelegate.inactiveColor != inactiveColor;
  }
}
