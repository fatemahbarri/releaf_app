import 'package:flutter/material.dart';
import 'AdminBar.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3FFE2),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 20, 18, 10),
          child: Column(
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
              const Center(
                child: Text(
                  'Welcome, Admin',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
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
                      children: const [
                        Expanded(
                          child: _DashboardCard(
                            title: 'Total Users',
                            value: '200',
                          ),
                        ),
                        SizedBox(width: 24),
                        Expanded(
                          child: _DashboardCard(
                            title: 'Active Users',
                            value: '115',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    Row(
                      children: [
                        const Expanded(
                          child: _DashboardCard(
                            title: 'Total Bins',
                            value: '50',
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(28),
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => ReportedIssuesPage(),
                              //   ),
                              // );
                            },
                            child: const _DashboardCard(
                              title: 'Reported\nIssues',
                              value: '4',
                              valueColor: Color(0xFFC70000),
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
