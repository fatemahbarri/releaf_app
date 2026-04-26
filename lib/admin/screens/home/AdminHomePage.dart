import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../widgets/admin_background.dart';
import '../../theme/admin_theme.dart';
import '../../widgets/AdminBar.dart';
import '../users/AdminUserManagment.dart';
import '../bins/AdminBinsPage.dart';

import 'widgets/header.dart';
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
        _firestore.collection('issues').get(),
        _firestore.collection('issues').where('isRead', isEqualTo: false).get(),
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

      final filteredTotalUsers = totalUsersSnapshot.docs.where((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final email = (data['email'] ?? '').toString().toLowerCase().trim();
        return !email.endsWith('@releaf.com');
      }).toList();

      final filteredActiveUsers = activeUsersSnapshot.docs.where((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final email = (data['email'] ?? '').toString().toLowerCase().trim();
        return !email.endsWith('@releaf.com');
      }).toList();

      setState(() {
        displayedAdminName = resolvedAdminName;
        totalUsers = filteredTotalUsers.length;
        activeUsers = filteredActiveUsers.length;
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
    return Scaffold(
      body: AdminBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 10),
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
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
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          HomeHeader(notifications: newNotifications),

                          const SizedBox(height: 28),

                          // Welcome text
                          Center(
                            child: Text(
                              'Welcome Back, $displayedAdminName !',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                                color: Color.fromARGB(255, 12, 75, 38),
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Scrollable content
                          Expanded(
                            child: SingleChildScrollView(
                              physics: const ClampingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 4),
                                    child: Text(
                                      'Dashboard',
                                      style: TextStyle(
                                        fontSize: 29,
                                        fontWeight: FontWeight.w700,
                                        color: AdminTheme.textMuted,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 18),
                                  SummaryCard(
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
                                          child: DashboardCard(
                                            title: 'Total Users',
                                            value: totalUsers.toString(),
                                            icon: Icons.people_alt_rounded,
                                            startColor: Color(0xFF457660),
                                            endColor: Color(0xFF11995D),
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
                                            startColor: Color(0xFF146B66),
                                            endColor: Color(0xFF238B53),
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
                                            startColor: Color(0xFF23416C),
                                            endColor: Color(0xFF2E86C1),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: DashboardCard(
                                          title: 'Reported Issues',
                                          value: reportedIssues.toString(),
                                          icon: Icons.report_problem_outlined,
                                          startColor: Color(0xFF522D22),
                                          endColor: Color(0xFFF4511E),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
          ),
        ),
      ),
      bottomNavigationBar: const AdminBar(selectedIndex: 0),
    );
  }
}
