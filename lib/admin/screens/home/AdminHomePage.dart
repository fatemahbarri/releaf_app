import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../theme/admin_theme.dart';
import '../../widgets/AdminBar.dart';
import '../users/AdminUserManagment.dart';
import '../bins/AdminBinsPage.dart';

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

  static const Color primary = Color(0xFF7FB77E);
  static const Color secondary = Color(0xFF5E9C76);
  static const Color background = Color(0xFFF7FBF2);
  static const Color textDark = Color(0xFF2F5D50);
  static const Color textMedium = Color(0xFF4E6A57);

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

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [primary, secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(24),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.dashboard_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              isLoading ? 'Welcome...' : 'Welcome, $displayedAdminName',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(
                Icons.notifications_none_rounded,
                color: Colors.white,
                size: 30,
              ),
              if (newNotifications > 0)
                Positioned(
                  right: -4,
                  top: -4,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: AdminTheme.error,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      newNotifications.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildTopBar(),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 12),
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: secondary,
                        ),
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
                                const Text(
                                  'Dashboard',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: textDark,
                                  ),
                                ),

                                const SizedBox(height: 16),

                                SummaryCard(
                                  totalUsers: totalUsers,
                                  activeUsers: activeUsers,
                                  inactiveUsers: inactiveUsers,
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
                                          startColor: const Color(0xFF457660),
                                          endColor: const Color(0xFF11995D),
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
                                          startColor: const Color(0xFF146B66),
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
                                        child: DashboardCard(
                                          title: 'Total Bins',
                                          value: totalBins.toString(),
                                          icon: Icons.delete_outline_rounded,
                                          startColor: const Color(0xFF23416C),
                                          endColor: const Color(0xFF2E86C1),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: DashboardCard(
                                        title: 'Reported Issues',
                                        value: reportedIssues.toString(),
                                        icon: Icons.report_problem_outlined,
                                        startColor: const Color(0xFF522D22),
                                        endColor: const Color(0xFFF4511E),
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
    );
  }
}