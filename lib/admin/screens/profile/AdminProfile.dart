import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../widgets/AdminBar.dart';
import '../../widgets/admin_background.dart';
import '../../widgets/admin_header.dart';
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

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: AdminBackground(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return Scaffold(
      body: AdminBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
          child: Column(
            children: [
              const AdminHeader(
                title: 'Admin Profile',
                showBack: false,
              ),
              const SizedBox(height: 28),
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 170,
                      height: 170,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AdminTheme.card,
                        border: Border.all(
                          color: AdminTheme.primary,
                          width: 4,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x22000000),
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 120,
                        color: AdminTheme.primary,
                      ),
                    ),
                    Positioned(
                      right: -2,
                      bottom: -2,
                      child: GestureDetector(
                        onTap: _openEditPage,
                        child: Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AdminTheme.primary,
                            border: Border.all(
                              color: AdminTheme.background,
                              width: 2,
                            ),
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Text(
                adminName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AdminTheme.primary,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 44),
              _infoCard(
                title: 'Email',
                value: adminEmail,
              ),
              _passwordCard(),
              InkWell(
                onTap: _logout,
                borderRadius: BorderRadius.circular(142),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(142),
                    color: AdminTheme.primary,
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x22000000),
                        blurRadius: 6,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 46,
                  ),
                  margin: const EdgeInsets.only(bottom: 16),
                  child: const Text(
                    'Log Out',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
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
    required String title,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 28),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 22),
      decoration: BoxDecoration(
        border: Border.all(
          color: AdminTheme.border,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(16),
        color: AdminTheme.card,
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AdminTheme.primary,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              color: AdminTheme.textMuted,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _passwordCard() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 60),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 21),
      decoration: BoxDecoration(
        border: Border.all(
          color: AdminTheme.border,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(16),
        color: AdminTheme.card,
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Password',
                style: TextStyle(
                  color: AdminTheme.primary,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 17),
              Text(
                '**************',
                style: TextStyle(
                  color: AdminTheme.textMuted,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: _openEditPage,
            icon: const Icon(
              Icons.edit_outlined,
              size: 30,
              color: AdminTheme.textDark,
            ),
          ),
        ],
      ),
    );
  }
}
