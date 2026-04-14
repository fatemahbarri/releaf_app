import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/app_background.dart'; // 🔥 إضافة الخلفية
import 'AdminBar.dart';

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

  int totalUsers = 0;
  int activeUsers = 0;
  int totalBins = 0;
  int reportedIssues = 0;

  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchDashboardStats();
  }

  Future<void> fetchDashboardStats() async {
    try {
      final totalUsersSnapshot = await _firestore.collection('users').get();

      final activeUsersSnapshot = await _firestore
          .collection('users')
          .where('accountStatus', isEqualTo: 'active')
          .get();

      final totalBinsSnapshot = await _firestore.collection('bins').get();

      final reportedIssuesSnapshot = await _firestore.collection('reports').get();

      if (!mounted) return;

      setState(() {
        totalUsers = totalUsersSnapshot.docs.length;
        activeUsers = activeUsersSnapshot.docs.length;
        totalBins = totalBinsSnapshot.docs.length;
        reportedIssues = reportedIssuesSnapshot.docs.length;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        // 🔥 هنا لفّينا الصفحة كلها بالخلفية
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 20, 18, 10),
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
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Icon(
                              Icons.notifications_none_rounded,
                              size: 42,
                              color: Color(0xFF4D9B63),
                            ),
                          ),
                          const SizedBox(height: 55),
                          Center(
                            child: Text(
                              'Welcome, ${widget.adminName}', // 🔥 الاسم الديناميكي
                              style: const TextStyle(
                                fontSize: 34,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 70),
                          const Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: Text(
                              'Dashboard',
                              style: TextStyle(
                                fontSize: 31,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF675F5A),
                              ),
                            ),
                          ),
                          const SizedBox(height: 35),
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: _DashboardCard(
                                        title: 'Total Users',
                                        value: totalUsers.toString(),
                                      ),
                                    ),
                                    const SizedBox(width: 24),
                                    Expanded(
                                      child: _DashboardCard(
                                        title: 'Active Users',
                                        value: activeUsers.toString(),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 28),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _DashboardCard(
                                        title: 'Total Bins',
                                        value: totalBins.toString(),
                                      ),
                                    ),
                                    const SizedBox(width: 24),
                                    Expanded(
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(28),
                                        onTap: () {},
                                        child: _DashboardCard(
                                          title: 'Reported\nIssues',
                                          value: reportedIssues.toString(),
                                          valueColor: const Color(0xFFC70000),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                              ],
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

class _DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final Color valueColor;

  const _DashboardCard({
    required this.title,
    required this.value,
    this.valueColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: const Color(0xFF41A86A),
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 10,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 22),
            Text(
              value,
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w700,
                color: valueColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}