import 'package:flutter/material.dart';
import 'package:releaf_app/widgets/releaf_ui.dart';
import 'package:releaf_app/widgets/app_background.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:releaf_app/widgets/app_top_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:releaf_app/user/llm/Chatbot.dart';
import 'package:releaf_app/user/UserWidgets/UserBottomNav.dart';
import 'package:releaf_app/user/Home/RecyclingProgressPage.dart';
import 'package:releaf_app/user/Home/UserNotificationsPage.dart';
import 'package:releaf_app/user/UserWidgets/ImageSlider.dart';

class HomePageUser extends StatefulWidget {
  const HomePageUser({super.key});

  @override
  State<HomePageUser> createState() => _HomePageUserState();
}

class _HomePageUserState extends State<HomePageUser> {
  String userName = 'User';
  bool isLoadingName = true;

  bool get _isDark => Theme.of(context).brightness == Brightness.dark;

  Color get _textColor => _isDark ? Colors.white : const Color(0xFF263328);

  Color get _bodyColor => _isDark ? Colors.white70 : const Color(0xFF4E6A57);

  Color get _cardColor => _isDark ? const Color(0xFF1A2520) : Colors.white;

  Color get _borderColor =>
      _isDark ? const Color(0xFF355246) : const Color(0xFFD6EBCF);

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

  void _openNotifications() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const UserNotificationsPage(),
      ),
    );
  }

  Stream<int> _notificationsCountStream() {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Stream.value(0);
    }

    return FirebaseFirestore.instance
        .collection('issues')
        .where('userId', isEqualTo: user.uid)
        .where('isReadByUser', isEqualTo: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Stack(
                children: [
                  AppTopBar(
                    title: isLoadingName ? 'Welcome...' : 'Welcome, $userName',
                    subtitle: 'Recycle today for a cleaner tomorrow!',
                    icon: Icons.eco_rounded,
                    showBackButton: false,
                    showNotifications: false,
                    gradientColors: _isDark
                        ? const [
                            Color(0xFF1B3A31),
                            Color(0xFF2F5D50),
                          ]
                        : const [
                            Color(0xFF7FB77E),
                            Color(0xFF5E9C76),
                          ],
                  ),
                  Positioned(
                    top: 12,
                    right: 16,
                    child: StreamBuilder<int>(
                      stream: _notificationsCountStream(),
                      builder: (context, snapshot) {
                        final count = snapshot.data ?? 0;

                        return InkWell(
                          onTap: _openNotifications,
                          borderRadius: BorderRadius.circular(50),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: _isDark
                                      ? const Color(0xFF1A2520)
                                      : Colors.white.withOpacity(0.95),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(
                                        _isDark ? 0.30 : 0.08,
                                      ),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.notifications_none_rounded,
                                  color: _isDark
                                      ? Colors.white
                                      : ReLeafColors.primary,
                                  size: 24,
                                ),
                              ),
                              if (count > 0)
                                Positioned(
                                  top: -2,
                                  right: -2,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                      vertical: 1,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      count > 99 ? '99+' : count.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 18, 16, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(22),
                        child: const ImageSlider(),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Welcome to ReLeaf',
                        textAlign: TextAlign.center,
                        style: ReLeafTextStyles.title.copyWith(
                          fontSize: 24,
                          color: _textColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Classify waste, find recycling bins, and get recycling guidance easily.',
                        textAlign: TextAlign.center,
                        style: ReLeafTextStyles.body.copyWith(
                          fontSize: 15,
                          color: _bodyColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildRecyclingGameCard(),
                      const SizedBox(height: 16),
                      _buildInfoBox(),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const UserBottomNav(
          currentIndex: 0,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(
            bottom: 0,
            right: 8,
          ),
          child: FloatingActionButton(
            onPressed: _openChat,
            backgroundColor: ReLeafColors.secondary,
            foregroundColor: Colors.white,
            child: const Icon(Icons.chat_bubble_outline),
          ),
        ),
      ),
    );
  }

  Widget _buildRecyclingGameCard() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const RecyclingProgressPage(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: _cardColor,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: _borderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_isDark ? 0.25 : 0.06),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              Icons.eco_rounded,
              size: 50,
              color: ReLeafColors.primary,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recycling Progress',
                    style: ReLeafTextStyles.title.copyWith(
                      fontSize: 20,
                      color: _textColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Tap to grow your plant 🌱',
                    style: ReLeafTextStyles.body.copyWith(
                      color: _bodyColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: _isDark ? Colors.white70 : Colors.black54,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoBox() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _isDark ? const Color(0xFF1A2520) : const Color(0xFFEAF6E3),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _borderColor),
      ),
      child: Row(
        children: [
          Icon(
            Icons.chat_bubble_outline,
            color: ReLeafColors.primary,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Use the chatbot if you need help knowing where an item belongs.',
              style: ReLeafTextStyles.body.copyWith(
                color: _bodyColor,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
