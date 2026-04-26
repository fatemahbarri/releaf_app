import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../widgets/AdminBar.dart';
import '../../widgets/admin_background.dart';
import '../../widgets/admin_header.dart';
import '../../theme/admin_theme.dart';
import 'AdminUserManagment.dart';

class AdminEditUser extends StatefulWidget {
  final Map<String, dynamic>? user;

  const AdminEditUser({super.key, this.user});

  @override
  State<AdminEditUser> createState() => _AdminEditUserState();
}

class _AdminEditUserState extends State<AdminEditUser> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late String status;

  bool isSaving = false;
  bool isBlocking = false;

  @override
  void initState() {
    super.initState();

    final currentUser = widget.user ??
        {
          'name': 'Sara Abdullah',
          'email': 'sara@gmail.com',
          'status': 'Active',
          'username': 'sara',
        };

    final fullName = currentUser['name']?.toString() ?? '';
    final nameParts = fullName.split(' ');

    final firstName = nameParts.isNotEmpty ? nameParts.first : '';
    final lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';
    final email = currentUser['email']?.toString() ?? '';

    final rawStatus = (currentUser['status'] ?? '').toString().toLowerCase();
    final rawAccountStatus =
        (currentUser['accountStatus'] ?? '').toString().toLowerCase();

    final currentStatusValue =
        rawAccountStatus.isNotEmpty ? rawAccountStatus : rawStatus;

    if (currentStatusValue == 'active') {
      status = 'Active';
    } else if (currentStatusValue == 'blocked') {
      status = 'Blocked';
    } else {
      status = 'Inactive';
    }

    firstNameController = TextEditingController(text: firstName);
    lastNameController = TextEditingController(text: lastName);
    usernameController = TextEditingController(
      text: currentUser['username']?.toString().isNotEmpty == true
          ? currentUser['username'].toString()
          : (email.contains('@')
              ? email.split('@').first
              : firstName.toLowerCase()),
    );
    emailController = TextEditingController(text: email);
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> saveUserChanges() async {
    final docId = widget.user?['docId']?.toString();

    if (docId == null || docId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User ID not found')),
      );
      return;
    }

    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();
    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final fullName = '$firstName $lastName'.trim();

    if (firstName.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('First name and email are required')),
      );
      return;
    }

    setState(() => isSaving = true);

    try {
      await _firestore.collection('users').doc(docId).update({
        'name': fullName,
        'email': email,
        'username': username,
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User updated successfully')),
      );

      Navigator.pop(context); // ✅ رجوع طبيعي
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update user: $e')),
      );
    } finally {
      if (mounted) setState(() => isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final fullName =
        '${firstNameController.text} ${lastNameController.text}'.trim();

    return Scaffold(
      body: AdminBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 24, bottom: 20),
          child: Column(
            children: [
              const AdminHeader(
                title: 'Edit User',
                showBack: true,
              ),
              const SizedBox(height: 10),
              const CircleAvatar(
                radius: 70,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 90,
                  color: AdminTheme.secondary,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                fullName.isEmpty ? 'User Profile' : fullName,
                style: const TextStyle(
                  color: AdminTheme.textDark,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              _buildField(
                  controller: firstNameController, hintText: 'First name'),
              _buildField(
                  controller: lastNameController, hintText: 'Second name'),
              _buildField(controller: usernameController, hintText: 'Username'),
              _buildField(controller: emailController, hintText: 'Email'),
              const SizedBox(height: 28),
              ElevatedButton(
                onPressed: isSaving ? null : saveUserChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AdminTheme.primary,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                child: isSaving
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AdminBar(selectedIndex: 1),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String hintText,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14, left: 43, right: 43),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: AdminTheme.border),
        color: AdminTheme.card,
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(
          color: AdminTheme.textDark,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
