import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:releaf_app/widgets/app_top_bar.dart';
import 'package:releaf_app/l10n/app_localizations.dart';

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

  bool get isDark => Theme.of(context).brightness == Brightness.dark;

  Color get cardBg => isDark ? const Color(0xFF1F2D28) : AdminTheme.card;
  Color get borderColor => isDark ? Colors.white10 : AdminTheme.border;
  Color get titleColor => isDark ? Colors.white : AdminTheme.textDark;
  Color get subTextColor => isDark ? Colors.white70 : AdminTheme.textMuted;
  Color get hintColor => isDark ? Colors.white54 : const Color(0xFF8A8A8A);
  Color get avatarBg => isDark ? const Color(0xFF31443B) : Colors.white;
  Color get topBarStart =>
      isDark ? const Color(0xFF1F2D28) : AdminTheme.primary;
  Color get topBarEnd =>
      isDark ? const Color(0xFF31443B) : AdminTheme.secondary;

  @override
  void initState() {
    super.initState();

    final currentUser = widget.user ?? {};

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
        SnackBar(
          content: Text(AppLocalizations.of(context)!.adminEditUserIdNotFound),
        ),
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
        SnackBar(
          content: Text(AppLocalizations.of(context)!.adminEditUserRequiredFields),
        ),
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
        SnackBar(
          content: Text(AppLocalizations.of(context)!.adminEditUserUpdated),
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)!.adminEditUserFailedUpdate(e.toString()),
          ),
        ),
      );
    } finally {
      if (mounted) setState(() => isSaving = false);
    }
  }

  Future<void> _confirmBlockUser() async {
    final userName =
        '${firstNameController.text.trim()} ${lastNameController.text.trim()}'
            .trim();

    final actionText = status == 'Blocked'
    ? AppLocalizations.of(context)!.adminEditUserUnblockAction
    : AppLocalizations.of(context)!.adminEditUserBlockAction;

    final displayName = userName.isEmpty
        ? AppLocalizations.of(context)!.adminEditUserThisUser
        : userName;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: cardBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: Text(
            AppLocalizations.of(context)!.adminEditUserConfirmAction,
            style: TextStyle(
              color: titleColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            AppLocalizations.of(context)!
                .adminEditUserConfirmBlock(actionText, displayName),
            style: TextStyle(color: subTextColor),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(
                AppLocalizations.of(context)!.cancel,
                style: TextStyle(color: subTextColor),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    status == 'Blocked' ? AdminTheme.primary : AdminTheme.error,
              ),
              child: Text(
                AppLocalizations.of(context)!.adminEditUserConfirm,
                style: const TextStyle(color: Colors.white),
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
        SnackBar(
          content: Text(AppLocalizations.of(context)!.adminEditUserIdNotFound),
        ),
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
                ? AppLocalizations.of(context)!.adminEditUserBlockedMsg
                : AppLocalizations.of(context)!.adminEditUserUnblockedMsg,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)!.adminEditUserFailedStatus(e.toString()),
          ),
        ),
      );
    } finally {
      if (mounted) setState(() => isBlocking = false);
    }
  }

  Widget _buildAvatar() {
    return Container(
      width: 128,
      height: 128,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: avatarBg,
        border: Border.all(
          color: isDark ? Colors.white24 : Colors.white,
          width: 5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.25 : 0.10),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Icon(
        Icons.person,
        size: 82,
        color: isDark ? Colors.white : AdminTheme.secondary,
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
        border: Border.all(color: borderColor),
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.20 : 0.04),
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(
          color: titleColor,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: hintColor,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buttonsRow() {
    return Padding(
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
                  : Text(
                        AppLocalizations.of(context)!.adminEditUserSave,
                        style: const TextStyle(
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
                backgroundColor:
                    status == 'Blocked' ? Colors.grey : AdminTheme.error,
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
                      status == 'Blocked' 
                      ? AppLocalizations.of(context)!.adminEditUserUnblock
                      : AppLocalizations.of(context)!.adminEditUserBlock,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
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
                  title: AppLocalizations.of(context)!.adminEditUserTitle,
                  icon: Icons.person,
                  showBackButton: true,
                  showNotifications: false,
                  gradientColors: [
                    topBarStart,
                    topBarEnd,
                  ],
                ),
                const SizedBox(height: 10),
                _buildAvatar(),
                const SizedBox(height: 16),
                Text(
                  fullName.isEmpty 
                  ? AppLocalizations.of(context)!.adminEditUserProfile
                  : fullName,
                  style: TextStyle(
                    color: titleColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                _buildField(
                  controller: firstNameController,
                  hintText: AppLocalizations.of(context)!.adminEditUserFirstName,
                ),
                _buildField(
                  controller: lastNameController,
                  hintText: AppLocalizations.of(context)!.adminEditUserSecondName,
                ),
                _buildField(
                  controller: usernameController,
                  hintText: AppLocalizations.of(context)!.adminEditUserUsername,
                ),
                _buildField(
                  controller: emailController,
                  hintText: AppLocalizations.of(context)!.adminEditUserEmail,
                ),
                const SizedBox(height: 20),
                _buttonsRow(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const AdminBar(selectedIndex: 1),
      ),
    );
  }
}
