import 'package:flutter/material.dart';
import 'package:releaf_app/widgets/releaf_ui.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:releaf_app/user/ReportIssueUser.dart';
import 'package:releaf_app/llm/Chatbot.dart';

import 'package:releaf_app/user/LocationPage.dart';
import 'package:releaf_app/user/Profile.dart';
import 'package:releaf_app/classification/image_classifier_screen.dart';

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

  void _onBottomTap(int index) {
    if (index == 0) return;

    if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const ImageClassifierScreen(),
        ),
      );
    }

    if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LocationPage(),
        ),
      );
    }

    if (index == 3) {
      final user = FirebaseAuth.instance.currentUser;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => Profile(
            name: userName,
            email: user?.email ?? 'user@email.com',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ReLeafColors.background,
      drawer: _buildSideMenu(),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            ReLeafHeader(
              title: isLoadingName ? 'Welcome...' : 'Welcome, $userName',
              subtitle: 'Recycle today for a cleaner tomorrow!',
              icon: Icons.eco_rounded,
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReLeafButton(
                      text: 'Menu',
                      icon: Icons.menu_rounded,
                      small: true,
                      onPressed: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                    ),

                    const SizedBox(height: 22),

                    ReLeafCard(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/User_home.png',
                            height: 250,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Welcome to ReLeaf',
                            style: ReLeafTextStyles.title.copyWith(
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Classify waste, find recycling bins, and get recycling guidance easily.',
                            textAlign: TextAlign.center,
                            style: ReLeafTextStyles.body.copyWith(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    const ReLeafInfoBox(
                      text:
                          'Use the chatbot if you need help knowing where an item belongs.',
                      icon: Icons.chat_bubble_outline,
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),

            ReLeafBottomBar(
              selectedIndex: 0,
              onTap: _onBottomTap,
            ),
          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 75, right: 8),
        child: FloatingActionButton(
          onPressed: _openChat,
          backgroundColor: ReLeafColors.secondary,
          foregroundColor: Colors.white,
          child: const Icon(Icons.chat_bubble_outline),
        ),
      ),
    );
  }

  Widget _buildSideMenu() {
    return Drawer(
      width: MediaQuery.of(context).size.width,
      backgroundColor: ReLeafColors.background,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'More',
                    style: ReLeafTextStyles.title.copyWith(fontSize: 30),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: ReLeafColors.lightGreen,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.close_rounded,
                        color: ReLeafColors.textDark,
                        size: 28,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

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

              Text(
                'ReLeaf v1.0.0 © 2026',
                style: ReLeafTextStyles.subtitle.copyWith(
                  color: const Color(0xFF8A8A8A),
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
    Color color = ReLeafColors.textMedium,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: ReLeafCard(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Row(
          children: [
            Icon(
              icon,
              color: color == const Color(0xFFE85A5A)
                  ? color
                  : ReLeafColors.textDark,
              size: 28,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: ReLeafTextStyles.title.copyWith(
                fontSize: 18,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}