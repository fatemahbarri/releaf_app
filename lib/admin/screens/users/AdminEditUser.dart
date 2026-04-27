import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../widgets/AdminBar.dart';
import '../../widgets/admin_background.dart';
import '../../theme/admin_theme.dart';

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

  static const Color primary = Color(0xFF7FB77E);
  static const Color secondary = Color(0xFF5E9C76);
  static const Color lightGreen = Color(0xFFEAF6E3);
  static const Color border = Color(0xFFDCE8D7);
  static const Color textDark = Color(0xFF2F5D50);
  static const Color textMedium = Color(0xFF4E6A57);

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
          : (email.contains('@') ? email.split('@').first : firstName.toLowerCase()),
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

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update user: $e')),
      );
    } finally {
      if (mounted) setState(() => isSaving = false);
    }
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
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
          ),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.manage_accounts_outlined,
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
                  'Edit User',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Update user information',
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

  Widget _buildField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        border: Border.all(color: border),
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(
          color: textDark,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color(0xFF8A9A8C),
          ),
          prefixIcon: Icon(
            icon,
            color: textMedium,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  Widget _saveButton() {
    return GestureDetector(
      onTap: isSaving ? null : saveUserChanges,
      child: Opacity(
        opacity: isSaving ? 0.6 : 1,
        child: Container(
          width: double.infinity,
          height: 56,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [primary, secondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: primary.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: isSaving
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : const Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final fullName =
        '${firstNameController.text} ${lastNameController.text}'.trim();

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
                      Container(
                        width: 130,
                        height: 130,
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

                      const SizedBox(height: 18),

                      Text(
                        fullName.isEmpty ? 'User Profile' : fullName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: textDark,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 26),

                      _buildField(
                        controller: firstNameController,
                        hintText: 'First name',
                        icon: Icons.person_outline,
                      ),
                      _buildField(
                        controller: lastNameController,
                        hintText: 'Second name',
                        icon: Icons.badge_outlined,
                      ),
                      _buildField(
                        controller: usernameController,
                        hintText: 'Username',
                        icon: Icons.alternate_email,
                      ),
                      _buildField(
                        controller: emailController,
                        hintText: 'Email',
                        icon: Icons.email_outlined,
                      ),

                      const SizedBox(height: 14),

                      _saveButton(),

                      const SizedBox(height: 24),
                    ],
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
}