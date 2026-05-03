import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:releaf_app/admin/screens/reports/AdminReportIssue.dart';
import 'package:releaf_app/widgets/app_top_bar.dart';

import '../../theme/admin_theme.dart';
import '../../widgets/AdminBar.dart';
import '../../widgets/admin_background.dart';

import '../users/AdminUserManagment.dart';
import '../bins/AdminBinsPage.dart';
import '../notifications/AdminNotificationsOverlay.dart';

import 'widgets/dashboard_card.dart';
import 'widgets/summary_card.dart';

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
  int blockedUsers = 0;
  int totalBins = 0;
  int reportedIssues = 0;
  int newNotifications = 0;

  String displayedAdminName = 'Admin';

  bool isLoading = true;
  String? errorMessage;

  static const Color primary = Color(0xFF7FB77E);
  static const Color secondary = Color(0xFF5E9C76);
  static const Color textDark = Color(0xFF2F5D50);

  bool get isDark => Theme.of(context).brightness == Brightness.dark;

  Color get titleColor => isDark ? Colors.white : textDark;
  Color get subTextColor => isDark ? Colors.white70 : AdminTheme.textMuted;
  Color get topBarStart => isDark ? const Color(0xFF1F2D28) : primary;
  Color get topBarEnd => isDark ? const Color(0xFF31443B) : secondary;

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
        _firestore
            .collection('users')
            .where('accountStatus', isEqualTo: 'blocked')
            .get(),
        _firestore.collection('bins').get(),
        _firestore.collection('issues').get(),
        _firestore
            .collection('issues')
            .where('status', isEqualTo: 'unread')
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
      final blockedUsersSnapshot = results[2] as QuerySnapshot;
      final totalBinsSnapshot = results[3] as QuerySnapshot;
      final reportedIssuesSnapshot = results[4] as QuerySnapshot;
      final newNotificationsSnapshot = results[5] as QuerySnapshot;

      String resolvedAdminName = widget.adminName;

      if (currentAdminDoc != null && currentAdminDoc.exists) {
        final adminData = currentAdminDoc.data() as Map<String, dynamic>?;
        final firestoreName = adminData?['name']?.toString().trim();

        if (firestoreName != null && firestoreName.isNotEmpty) {
          resolvedAdminName = firestoreName;
        }
      }

      bool isNormalUser(QueryDocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        final email = (data['email'] ?? '').toString().toLowerCase().trim();
        return !email.endsWith('@releaf.com');
      }

      final filteredTotalUsers =
          totalUsersSnapshot.docs.where(isNormalUser).toList();

      final filteredActiveUsers =
          activeUsersSnapshot.docs.where(isNormalUser).toList();

      final filteredBlockedUsers =
          blockedUsersSnapshot.docs.where(isNormalUser).toList();

      setState(() {
        displayedAdminName = resolvedAdminName;
        totalUsers = filteredTotalUsers.length;
        activeUsers = filteredActiveUsers.length;
        blockedUsers = filteredBlockedUsers.length;
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
    final value = totalUsers - activeUsers - blockedUsers;
    return value < 0 ? 0 : value;
  }

  void _goToUserManagement(String filter) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AdminUserManagment(initialFilter: filter),
      ),
    );
  }

  void _goToBinManagement() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AdminBinsPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AdminBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              AppTopBar(
                title:
                    isLoading ? 'Welcome...' : 'Welcome, $displayedAdminName',
                icon: Icons.dashboard_rounded,
                showNotifications: true,
                notifications: newNotifications,
                gradientColors: [
                  topBarStart,
                  topBarEnd,
                ],
                onNotificationTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (_, __, ___) => AdminNotificationsOverlay(
                        newNotifications: newNotifications,
                      ),
                      transitionsBuilder: (_, animation, __, child) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, -1),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        );
                      },
                    ),
                  );
                },
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 18, 16, 12),
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(color: secondary),
                        )
                      : errorMessage != null
                          ? Center(
                              child: Text(
                                errorMessage!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: AdminTheme.error,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          : SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Dashboard',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: titleColor,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  SummaryCard(
                                    totalUsers: totalUsers,
                                    activeUsers: activeUsers,
                                    inactiveUsers: inactiveUsers,
                                    blockedUsers: blockedUsers,
                                  ),
                                  const SizedBox(height: 22),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () =>
                                              _goToUserManagement('All Users'),
                                          child: DashboardCard(
                                            title: 'Total Users',
                                            value: totalUsers.toString(),
                                            icon: Icons.people_alt_rounded,
                                            startColor: const Color(0xFF5E9C76),
                                            endColor: const Color(0xFF7CA385),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () =>
                                              _goToUserManagement('Active'),
                                          child: DashboardCard(
                                            title: 'Active Users',
                                            value: activeUsers.toString(),
                                            icon:
                                                Icons.person_add_alt_1_rounded,
                                            startColor: const Color(0xFF4E8F5F),
                                            endColor: const Color(0xFF66A877),
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
                                          child: DashboardCard(
                                            title: 'Total Bins',
                                            value: totalBins.toString(),
                                            icon: Icons.delete_outline_rounded,
                                            startColor: const Color(0xFF3E6F5C),
                                            endColor: const Color(0xFF5E9C76),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    const AdminReportIssue(),
                                              ),
                                            );
                                          },
                                          child: DashboardCard(
                                            title: 'Reported Issues',
                                            value: reportedIssues.toString(),
                                            icon: Icons.report_problem_outlined,
                                            startColor: const Color(0xFFB85C38),
                                            endColor: const Color(0xFFD97A4A),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 24),
                                ],
                              ),
                            ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const AdminBar(selectedIndex: 0),
      ),
    );
  }
}
