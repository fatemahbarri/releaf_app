import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'AdminBar.dart';
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

    setState(() {
      isSaving = true;
    });

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

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AdminUserManagment(),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update user: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          isSaving = false;
        });
      }
    }
  }

  Future<void> blockUser() async {
    final docId = widget.user?['docId']?.toString();

    if (docId == null || docId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User ID not found')),
      );
      return;
    }

    setState(() {
      isBlocking = true;
    });

    try {
      final docRef = _firestore.collection('users').doc(docId);

      final doc = await docRef.get();
      final oldData = doc.data();
      final oldStatus = (oldData?['accountStatus'] ?? 'active').toString();

      await docRef.update({
        'accountStatus': 'blocked',
      });

      if (!mounted) return;

      setState(() {
        status = 'Blocked';
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('User has been blocked'),
          backgroundColor: const Color(0xFFD00000),
          duration: const Duration(seconds: 4),
          action: SnackBarAction(
            label: 'Undo',
            textColor: Colors.white,
            onPressed: () async {
              await docRef.update({
                'accountStatus': oldStatus,
              });

              if (!mounted) return;

              setState(() {
                status = oldStatus.capitalize();
              });
            },
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to block user: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          isBlocking = false;
        });
      }
    }
  }

  Future<void> showBlockDialog() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Block User'),
          content: const Text(
            'Are you sure you want to block this user?',
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context, true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD00000),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(
                Icons.block_rounded,
                color: Colors.white,
                size: 18,
              ),
              label: const Text(
                'Block',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await blockUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    final fullName =
        '${firstNameController.text} ${lastNameController.text}'.trim();

    return Scaffold(
      backgroundColor: const Color(0xFFF3FFE2),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 24, bottom: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: SizedBox(
                  height: 40,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AdminUserManagment(),
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.black,
                          size: 24,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: isBlocking ? null : showBlockDialog,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.70),
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x14000000),
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: isBlocking
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: Color(0xFFD00000),
                                  ),
                                )
                              : const Icon(
                                  Icons.block_rounded,
                                  size: 28,
                                  color: Color(0xFFD00000),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const CircleAvatar(
                radius: 70,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 90,
                  color: Color(0xFF7CA385),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                fullName.isEmpty ? 'User Profile' : fullName,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: status == 'Active'
                      ? const Color(0xFF7ACD0E)
                      : status == 'Blocked'
                          ? const Color(0xFFD00000)
                          : const Color(0xFFE47D0F),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                color: const Color(0xADB0B0B0),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                height: 1,
                width: double.infinity,
              ),
              const SizedBox(height: 24),
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
              const SizedBox(height: 28),
              ElevatedButton(
                onPressed: isSaving ? null : saveUserChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8DC149),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 60,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                child: isSaving
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 3),
                      )
                    : const Text(
                        'Save',
                        style: TextStyle(
                          color: Color(0xFF5B5656),
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
        border: Border.all(color: const Color(0xFFC4C4C4), width: 1),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: (_) {
          setState(() {});
        },
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color(0xFF9E9E9E),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
