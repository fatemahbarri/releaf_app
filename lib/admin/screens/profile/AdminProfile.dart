import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../widgets/AdminBar.dart';
import '../../widgets/admin_background.dart';
import '../../theme/admin_theme.dart';
import 'AdminProfileEdit.dart';
import '../../../auth/Login.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile({super.key});

  @override
  AdminProfileState createState() => AdminProfileState();
}

class AdminProfileState extends State<AdminProfile> {
  String adminName = 'Admin';
  String adminEmail = '';
  String adminPassword = '**************';

  bool isLoading = true;

  static const Color primary = Color(0xFF7FB77E);
  static const Color secondary = Color(0xFF5E9C76);
  static const Color lightGreen = Color(0xFFEAF6E3);
  static const Color border = Color(0xFFDCE8D7);
  static const Color textDark = Color(0xFF2F5D50);
  static const Color textMedium = Color(0xFF4E6A57);

  @override
  void initState() {
    super.initState();
    _loadAdminData();
  }

  Future<void> _loadAdminData() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      setState(() => isLoading = false);
      return;
    }

    adminEmail = user.email ?? '';

    final doc = await FirebaseFirestore.instance
        .collection('admins')
        .doc(user.uid)
        .get();

    if (!mounted) return;

    if (doc.exists) {
      final data = doc.data();

      setState(() {
        adminName = data?['name'] ?? 'Admin';
        adminEmail = data?['email'] ?? adminEmail;
        isLoading = false;
      });
    } else {
      setState(() {
        adminName = 'Admin';
        isLoading = false;
      });
    }
  }

  Future<void> _openEditPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AdminProfileEdit(
          currentName: adminName,
          currentEmail: adminEmail,
          currentPassword: adminPassword,
        ),
      ),
    );

    if (result != null && result is Map<String, String>) {
      setState(() {
        adminName = result['name'] ?? adminName;
        adminEmail = result['email'] ?? adminEmail;
        adminPassword = result['password'] ?? adminPassword;
      });

      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await FirebaseFirestore.instance
            .collection('admins')
            .doc(user.uid)
            .set({
          'name': adminName,
          'email': adminEmail,
          'role': 'admin',
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      }
    }
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginPage(isAdminMode: true),
      ),
      (route) => false,
    );
  }

  Widget _topBar() {
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
              Icons.person_outline,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Admin Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'View and manage your account',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _gradientButton({
    required String text,
    required IconData icon,
    required VoidCallback onTap,
    Color? overrideColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 13),
        decoration: BoxDecoration(
          color: overrideColor,
          gradient: overrideColor == null
              ? const LinearGradient(
                  colors: [primary, secondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          borderRadius: BorderRadius.circular(26),
          boxShadow: [
            BoxShadow(
              color: (overrideColor ?? primary).withOpacity(0.28),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: AdminBackground(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        bottomNavigationBar: AdminBar(selectedIndex: 4),
      );
    }

    return Scaffold(
      body: AdminBackground(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _topBar(),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 20),
                  child: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 135,
                            height: 135,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: lightGreen,
                              border: Border.all(
                                color: primary,
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
                              size: 82,
                              color: textDark,
                            ),
                          ),
                          Positioned(
                            right: -2,
                            bottom: 8,
                            child: GestureDetector(
                              onTap: _openEditPage,
                              child: Container(
                                width: 42,
                                height: 42,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: secondary,
                                  border: Border.all(
                                    color: AdminTheme.background,
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
                        adminName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: textDark,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 28),

                      _infoCard(
                        icon: Icons.email_outlined,
                        title: 'Email',
                        value: adminEmail,
                      ),

                      const SizedBox(height: 14),

                      _passwordCard(),

                      const SizedBox(height: 30),

                      _gradientButton(
                        text: 'Log Out',
                        icon: Icons.logout_rounded,
                        onTap: _logout,
                        overrideColor: AdminTheme.error,
                      ),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AdminBar(selectedIndex: 4),
    );
  }

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: lightGreen,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: textDark,
            size: 28,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: textDark,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: const TextStyle(
                    color: textMedium,
                    fontSize: 15,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _passwordCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: lightGreen,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(
            Icons.lock_outline,
            color: textDark,
            size: 28,
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Password',
                  style: TextStyle(
                    color: textDark,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  '**************',
                  style: TextStyle(
                    color: textMedium,
                    fontSize: 15,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: _openEditPage,
            child: Container(
              width: 42,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [primary, secondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Icon(
                Icons.edit_outlined,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}