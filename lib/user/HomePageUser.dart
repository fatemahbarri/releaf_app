import 'package:flutter/material.dart';
import 'package:releaf_app/widgets/app_background.dart';
import 'package:releaf_app/user/UserWidgets/UserBottomNav.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:releaf_app/user/ReportIssueUser.dart';
import 'package:releaf_app/llm/Chatbot.dart';

class HomePageUser extends StatefulWidget {
  const HomePageUser({super.key});

  @override
  State<HomePageUser> createState() => _HomePageUserState();
}

class _HomePageUserState extends State<HomePageUser> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String userName = 'User';
  bool isLoadingName = true;

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      setState(() {
        userName = 'User';
        isLoadingName = false;
      });
      return;
    }

    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (!mounted) return;

      setState(() {
        userName = doc.data()?['name'] ?? 'User';
        isLoadingName = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        userName = 'User';
        isLoadingName = false;
      });
    }
  }

  void _openChat() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const Chatbot(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,

        // 👇 من اليسار
        drawer: _buildSideMenu(),

        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 25),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                    icon: const Icon(
                      Icons.menu_rounded,
                      color: Color.fromARGB(255, 19, 87, 49),
                      size: 36,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  isLoadingName ? "Welcome..." : "Welcome, $userName",
                  style: const TextStyle(
                    color: Color(0xFF7CA385),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Recycle today for a cleaner tomorrow!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF675F5A),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 25),
                Image.asset(
                  'assets/images/User_home.png',
                  height: 260,
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: _openChat,
          backgroundColor: const Color(0xFF8DC149),
          child: const Icon(Icons.chat_bubble_outline),
        ),

        bottomNavigationBar: const UserBottomNav(
          currentIndex: 0,
        ),
      ),
    );
  }

  // ================= SIDE MENU =================
  Widget _buildSideMenu() {
    return Drawer(
      width: MediaQuery.of(context).size.width,
      backgroundColor: const Color(0xFFF3FFE2),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 34, 28, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.menu_rounded,
                    color: Color(0xFF499A64),
                    size: 38,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 46,
                      height: 46,
                      decoration: const BoxDecoration(
                        color: Color(0xFFCDE9C7),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close_rounded,
                        color: Color(0xFF2F4F35),
                        size: 28,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'More',
                style: TextStyle(
                  color: Color(0xFF499A64),
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 50),
              _buildMenuItem(
                icon: Icons.settings_outlined,
                title: 'Settings',
                onTap: () {},
              ),
              _buildMenuItem(
                icon: Icons.info_outline,
                title: 'About ReLeaf',
                onTap: () {},
              ),
              _buildMenuItem(
                icon: Icons.report_problem_outlined,
                title: 'Issues',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ReportIssueUser(),
                    ),
                  );
                },
              ),
              const Spacer(),
              _buildMenuItem(
                icon: Icons.translate_rounded,
                title: 'عربي',
                onTap: () {},
              ),
              _buildMenuItem(
                icon: Icons.logout_rounded,
                title: 'Logout',
                color: const Color(0xFFE85A5A),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();

                  if (!mounted) return;

                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/',
                    (route) => false,
                  );
                },
              ),
              const SizedBox(height: 8),
              const Text(
                'ReLeaf v1.0.0 © 2026',
                style: TextStyle(
                  color: Color(0xFF8A8A8A),
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color color = const Color(0xFF675F5A),
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 28),
        child: Row(
          children: [
            Icon(
              icon,
              color: color == const Color(0xFFE85A5A)
                  ? color
                  : const Color(0xFF499A64),
              size: 30,
            ),
            const SizedBox(width: 22),
            Text(
              title,
              style: TextStyle(
                color: color,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
