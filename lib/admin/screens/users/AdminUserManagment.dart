import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../widgets/AdminBar.dart';
import '../../widgets/admin_background.dart';
import '../../theme/admin_theme.dart';
import 'AdminEditUser.dart';

class AdminUserManagment extends StatefulWidget {
  final String initialFilter;

  const AdminUserManagment({
    super.key,
    this.initialFilter = 'All Users',
  });

  @override
  State<AdminUserManagment> createState() => _AdminUserManagmentState();
}

class _AdminUserManagmentState extends State<AdminUserManagment> {
  final TextEditingController searchController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> allUsers = [];
  List<Map<String, dynamic>> filteredUsers = [];
  late String selectedFilter;

  bool isLoading = true;
  String? errorMessage;

  static const Color primary = Color(0xFF7FB77E);
  static const Color secondary = Color(0xFF5E9C76);
  static const Color background = Color(0xFFF7FBF2);
  static const Color lightGreen = Color(0xFFEAF6E3);
  static const Color border = Color(0xFFDCE8D7);
  static const Color textDark = Color(0xFF2F5D50);
  static const Color textMedium = Color(0xFF4E6A57);

  @override
  void initState() {
    super.initState();
    selectedFilter = widget.initialFilter;
    fetchUsers();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> fetchUsers() async {
    try {
      final snapshot = await _firestore.collection('users').get();

      final users = snapshot.docs.map((doc) {
        final data = doc.data();
        final accountStatus =
            (data['accountStatus'] ?? 'inactive').toString().toLowerCase();

        String statusText;
        if (accountStatus == 'active') {
          statusText = 'Active';
        } else if (accountStatus == 'blocked') {
          statusText = 'Blocked';
        } else {
          statusText = 'Inactive';
        }

        return {
          'docId': doc.id,
          'name': (data['name'] ?? '').toString(),
          'email': (data['email'] ?? '').toString(),
          'status': statusText,
          'accountStatus': accountStatus,
          'username': (data['username'] ?? '').toString(),
        };
      }).toList();

      if (!mounted) return;

      setState(() {
        allUsers = users;
        isLoading = false;
      });

      applyFilters();
    } catch (e) {
      if (!mounted) return;

      setState(() {
        errorMessage = 'Failed to fetch users';
        isLoading = false;
      });
    }
  }

  void applyFilters() {
    final query = searchController.text.toLowerCase().trim();

    filteredUsers = allUsers.where((user) {
      final name = (user['name'] ?? '').toString().toLowerCase();
      final email = (user['email'] ?? '').toString().toLowerCase();
      final status = (user['status'] ?? '').toString().toLowerCase();

      if (email.endsWith('@releaf.com')) return false;

      final matchesSearch =
          query.isEmpty || name.contains(query) || email.contains(query);

      final matchesFilter =
          selectedFilter == 'All Users' || status == selectedFilter.toLowerCase();

      return matchesSearch && matchesFilter;
    }).toList();
  }

  void searchUsers(String value) {
    setState(() => applyFilters());
  }

  Color _statusColor(String status) {
    if (status == 'Active') return AdminTheme.success;
    if (status == 'Blocked') return AdminTheme.error;
    if (status == 'Inactive') return const Color(0xFFE47D0F);
    return Colors.grey;
  }

  Widget _topBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [primary, secondary],
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
              Icons.people_alt_outlined,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Users Management',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: border),
      ),
      child: TextField(
        controller: searchController,
        onChanged: searchUsers,
        decoration: const InputDecoration(
          hintText: 'Search User',
          hintStyle: TextStyle(color: Color(0xFF8A9A8C)),
          prefixIcon: Icon(Icons.search, color: textMedium),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  Widget _userCard(Map<String, dynamic> user) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 22,
            backgroundColor: lightGreen,
            child: Icon(Icons.person, color: textDark),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user['name'] ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user['email'] ?? '',
                  style: const TextStyle(color: textMedium),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: _statusColor(user['status']).withOpacity(0.2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              user['status'],
              style: TextStyle(
                color: _statusColor(user['status']),
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AdminEditUser(user: user),
                ),
              );
              await fetchUsers();
            },
            child: const Icon(Icons.edit_outlined, color: textDark),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      body: AdminBackground(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _topBar(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 18, 16, 12),
                  child: Column(
                    children: [
                      _searchBar(),
                      const SizedBox(height: 16),
                      Expanded(
                        child: isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: secondary,
                                ),
                              )
                            : filteredUsers.isEmpty
                                ? const Center(
                                    child: Text(
                                      'No users found',
                                      style: TextStyle(color: textMedium),
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: filteredUsers.length,
                                    itemBuilder: (_, i) =>
                                        _userCard(filteredUsers[i]),
                                  ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Container(
        color: background,
        child: const AdminBar(selectedIndex: 1),
      ),
    );
  }
}