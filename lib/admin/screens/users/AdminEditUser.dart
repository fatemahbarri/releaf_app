import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:releaf_app/widgets/app_top_bar.dart';

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

  @override
  void initState() {
    super.initState();

    final currentUser = widget.user ?? {};
    final bool showBackButton;

    final fullName = currentUser['name']?.toString() ?? '';
    final nameParts = fullName.split(' ');

    final firstName = nameParts.isNotEmpty ? nameParts.first : '';
    final lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';
    final email = currentUser['email']?.toString() ?? '';

    final rawAccountStatus =
        (currentUser['accountStatus'] ?? currentUser['status'] ?? '')
            .toString()
            .toLowerCase();

    if (rawAccountStatus == 'active') {
      status = 'Active';
    } else if (rawAccountStatus == 'blocked') {
      status = 'Blocked';
    } else {
      status = 'Inactive';
    }

    firstNameController = TextEditingController(text: firstName);
    lastNameController = TextEditingController(text: lastName);
    usernameController = TextEditingController(
      text: currentUser['username']?.toString() ?? '',
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
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update user: $e')),
      );
    } finally {
      if (mounted) setState(() => isSaving = false);
    }
  }

  Future<void> _confirmBlockUser() async {
    final userName =
        '${firstNameController.text.trim()} ${lastNameController.text.trim()}'
            .trim();

    final actionText = status == 'Blocked' ? 'unblock' : 'block';
    final displayName = userName.isEmpty ? 'this user' : userName;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Text('Confirm Action'),
          content: Text(
            'Are you sure you want to $actionText $displayName?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    status == 'Blocked' ? AdminTheme.primary : AdminTheme.error,
              ),
              child: const Text(
                'Confirm',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      await toggleBlockUser();
    }
  }

  Future<void> toggleBlockUser() async {
    final docId = widget.user?['docId']?.toString();

    if (docId == null || docId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User ID not found')),
      );
      return;
    }

    setState(() => isBlocking = true);

    try {
      final newStatus = status == 'Blocked' ? 'active' : 'blocked';

      await _firestore.collection('users').doc(docId).update({
        'accountStatus': newStatus,
      });

      if (!mounted) return;

      setState(() {
        status = newStatus == 'blocked' ? 'Blocked' : 'Active';
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            status == 'Blocked'
                ? 'User has been blocked'
                : 'User has been unblocked',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update user status: $e')),
      );
    } finally {
      if (mounted) setState(() => isBlocking = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final fullName =
        '${firstNameController.text.trim()} ${lastNameController.text.trim()}'
            .trim();

    return AdminBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                AppTopBar(
                  title: 'Edit User',
                  icon: Icons.person,
                  showBackButton: true,
                  showNotifications: false,
                  gradientColors: const [
                    AdminTheme.primary,
                    AdminTheme.secondary,
                  ],
                ),
                const SizedBox(height: 10),
                const CircleAvatar(
                  radius: 64,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 82,
                    color: AdminTheme.secondary,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  fullName.isEmpty ? 'User Profile' : fullName,
                  style: const TextStyle(
                    color: AdminTheme.textDark,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                _buildField(
                  controller: firstNameController,
                  hintText: 'First name',
                ),
                _buildField(
                  controller: lastNameController,
                  hintText: 'Second name',
                ),
                _buildField(
                  controller: usernameController,
                  hintText: 'Username',
                ),
                _buildField(
                  controller: emailController,
                  hintText: 'Email',
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: isSaving ? null : saveUserChanges,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AdminTheme.primary,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: isSaving
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : const Text(
                                  'Save',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: isBlocking ? null : _confirmBlockUser,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: status == 'Blocked'
                                ? Colors.grey
                                : AdminTheme.error,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: isBlocking
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : Text(
                                  status == 'Blocked' ? 'Unblock' : 'Block',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const AdminBar(selectedIndex: 1),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String hintText,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14, left: 40, right: 40),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: AdminTheme.border),
        color: AdminTheme.card,
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(
          color: AdminTheme.textDark,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
