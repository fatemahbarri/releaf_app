import 'package:flutter/material.dart';

import 'package:releaf_app/widgets/releaf_ui.dart';
import 'package:releaf_app/user/HomePageUser.dart';
import 'package:releaf_app/user/LocationPage.dart';
import 'package:releaf_app/classification/image_classifier_screen.dart';

class Profile extends StatefulWidget {
  final String name;
  final String email;
  final String password;

  const Profile({
    super.key,
    required this.name,
    required this.email,
    this.password = '**************',
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    if (index == 3) return;

    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomePageUser(),
        ),
      );
    }

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
  }

  void _handleLogout() {
    debugPrint('Log Out pressed');
  }

  void _handleEditProfile() {
    debugPrint('Edit profile pressed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ReLeafColors.background,
      body: SafeArea(
        child: Column(
          children: [
            ReLeafHeader(
              title: 'Profile',
              subtitle: 'View and manage your account',
              icon: Icons.person_outline,
              showBackButton: true,
              onBack: () => Navigator.pop(context),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 20),
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ReLeafColors.lightGreen,
                            border: Border.all(
                              color: ReLeafColors.primary,
                              width: 3,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 80,
                            color: ReLeafColors.textDark,
                          ),
                        ),
                        Positioned(
                          right: -2,
                          bottom: 8,
                          child: GestureDetector(
                            onTap: _handleEditProfile,
                            child: Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                color: ReLeafColors.secondary,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: ReLeafColors.background,
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    Text(
                      widget.name,
                      textAlign: TextAlign.center,
                      style: ReLeafTextStyles.title.copyWith(
                        fontSize: 28,
                      ),
                    ),

                    const SizedBox(height: 28),

                    _buildInfoCard(
                      icon: Icons.email_outlined,
                      title: 'Email',
                      value: widget.email,
                    ),

                    const SizedBox(height: 14),

                    _buildInfoCard(
                      icon: Icons.lock_outline,
                      title: 'Password',
                      value: widget.password,
                    ),

                    const SizedBox(height: 32),

                    ReLeafButton(
                      text: 'Log Out',
                      icon: Icons.logout_rounded,
                      onPressed: _handleLogout,
                    ),
                  ],
                ),
              ),
            ),

            ReLeafBottomBar(
              selectedIndex: _selectedIndex,
              onTap: _onItemTapped,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return ReLeafCard(
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.zero,
      color: ReLeafColors.lightGreen,
      child: Row(
        children: [
          Icon(
            icon,
            color: ReLeafColors.textDark,
            size: 28,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: ReLeafTextStyles.title.copyWith(fontSize: 18),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: ReLeafTextStyles.body.copyWith(fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}