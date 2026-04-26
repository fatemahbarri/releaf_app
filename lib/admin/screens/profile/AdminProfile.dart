import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../widgets/AdminBar.dart';
import 'AdminProfileEdit.dart';
import '../../../SplashScreen.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile({super.key});

  @override
  AdminProfileState createState() => AdminProfileState();
}

class AdminProfileState extends State<AdminProfile> {
  String adminName = "Admin";
  String adminEmail = "";
  String adminPassword = "**************";

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAdminData();
  }

  Future<void> _loadAdminData() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    adminEmail = user.email ?? "";

    final doc = await FirebaseFirestore.instance
        .collection('admins')
        .doc(user.uid)
        .get();

    if (doc.exists) {
      final data = doc.data();

      setState(() {
        adminName = data?['name'] ?? "Admin";
        adminEmail = data?['email'] ?? adminEmail;
        isLoading = false;
      });
    } else {
      setState(() {
        adminName = "Admin";
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

  void _logout() async {
    await FirebaseAuth.instance.signOut();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const SplashScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFFF3FFE2),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF3FFE2),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 170,
                      height: 170,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFC7D3C6),
                        border: Border.all(
                          color: const Color(0xFF446B54),
                          width: 4,
                        ),
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 120,
                        color: Color(0xFF446B54),
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
                            color: const Color(0xFF446B54),
                            border: Border.all(
                              color: const Color(0xFFF3FFE2),
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
              const SizedBox(height: 34),
              Text(
                adminName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF7CA385),
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 57),
              _infoCard(
                title: "Email",
                value: adminEmail,
              ),
              _passwordCard(),
              InkWell(
                onTap: _logout,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(142),
                    color: const Color(0xFF8DC149),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x40000000),
                        blurRadius: 4,
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
                    "Log Out",
                    style: TextStyle(
                      color: Color(0xFF9C1111),
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
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFF989898),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(14),
        color: const Color(0xFFCDE9C7),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 16),
      margin: const EdgeInsets.only(bottom: 32),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF498056),
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(
                color: Color(0xFF675F5A),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _passwordCard() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFF989898),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(14),
        color: const Color(0xFFCDE9C7),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.only(
        top: 16,
        bottom: 16,
        left: 21,
        right: 21,
      ),
      margin: const EdgeInsets.only(bottom: 80),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Password",
                style: TextStyle(
                  color: Color(0xFF498056),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 17),
              Text(
                "**************",
                style: TextStyle(
                  color: Color(0xFF675F5A),
                  fontSize: 20,
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
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
