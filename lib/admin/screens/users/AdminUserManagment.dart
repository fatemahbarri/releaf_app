import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../widgets/AdminBar.dart';
import '../../widgets/admin_background.dart';
import '../../theme/admin_theme.dart';
import '../home/AdminHomePage.dart';
import 'AdminEditUser.dart';

import '../../widgets/admin_header.dart';

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
        errorMessage = 'Failed to fetch users: $e';
        isLoading = false;
      });
    }
  }

  Future<void> _showDeleteDialog(Map<String, dynamic> user) async {
    final docId = user['docId'];

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete User'),
          content: const Text('Are you sure you want to delete this user?'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context, true),
              icon: const Icon(Icons.delete, color: Colors.white),
              label: const Text('Delete'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AdminTheme.error,
              ),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      await _deleteUser(docId);
    }
  }

  Future<void> _deleteUser(String docId) async {
    try {
      await _firestore.collection('users').doc(docId).delete();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User deleted successfully')),
      );

      await fetchUsers();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting user: $e')),
      );
    }
  }

  void applyFilters() {
    final query = searchController.text.toLowerCase().trim();

    filteredUsers = allUsers.where((user) {
      final name = (user['name'] ?? '').toString().toLowerCase();
      final email = (user['email'] ?? '').toString().toLowerCase().trim();
      final status = (user['status'] ?? '').toString().toLowerCase();

      if (email.endsWith('@releaf.com')) {
        return false;
      }

      final matchesSearch =
          query.isEmpty || name.contains(query) || email.contains(query);

      final matchesFilter = selectedFilter == 'All Users' ||
          status == selectedFilter.toLowerCase();

      return matchesSearch && matchesFilter;
    }).toList();
  }

  void searchUsers(String value) {
    setState(() {
      applyFilters();
    });
  }

  void updateFilter(String filter) {
    setState(() {
      selectedFilter = filter;
      applyFilters();
    });
  }

  void showFilterMenu(BuildContext context) async {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    final selected = await showMenu<String>(
      context: context,
      position: RelativeRect.fromRect(
        Rect.fromPoints(
          button.localToGlobal(Offset.zero, ancestor: overlay),
          button.localToGlobal(
            button.size.bottomRight(Offset.zero),
            ancestor: overlay,
          ),
        ),
        Offset.zero & overlay.size,
      ),
      items: const [
        PopupMenuItem(value: 'All Users', child: Text('All Users')),
        PopupMenuItem(value: 'Active', child: Text('Active')),
        PopupMenuItem(value: 'Inactive', child: Text('Inactive')),
        PopupMenuItem(value: 'Blocked', child: Text('Blocked')),
      ],
    );

    if (selected != null) {
      updateFilter(selected);
    }
  }

  Future<void> refreshUsers() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    await fetchUsers();
  }

  Color _statusColor(String status) {
    if (status == 'Active') return AdminTheme.success;
    if (status == 'Blocked') return AdminTheme.error;
    if (status == 'Inactive') return const Color(0xFFE47D0F);
    return const Color(0xFF9E9E9E);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AdminBackground(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
              child: Column(
                children: [
                  const AdminHeader(
                    title: 'Users Management',
                    showBack: false,
                  ),
                  const SizedBox(height: 14),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: AdminTheme.border,
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 48,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: AdminTheme.card,
                            border: Border.all(color: AdminTheme.border),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.search,
                                color: Color(0xFF8A8A8A),
                                size: 20,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  controller: searchController,
                                  onChanged: searchUsers,
                                  decoration: const InputDecoration(
                                    hintText: 'Search User',
                                    hintStyle: TextStyle(
                                      color: Color(0xFF8A8A8A),
                                      fontSize: 16,
                                    ),
                                    border: InputBorder.none,
                                    isDense: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Builder(
                        builder: (filterContext) {
                          return InkWell(
                            onTap: () => showFilterMenu(filterContext),
                            borderRadius: BorderRadius.circular(20),
                            child: const Padding(
                              padding: EdgeInsets.all(4),
                              child: Icon(
                                Icons.tune_rounded,
                                size: 24,
                                color: AdminTheme.textDark,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Filter: $selectedFilter',
                      style: const TextStyle(
                        color: AdminTheme.textMuted,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : errorMessage != null
                      ? Center(
                          child: Text(
                            errorMessage!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AdminTheme.error,
                            ),
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: refreshUsers,
                          child: filteredUsers.isEmpty
                              ? ListView(
                                  children: const [
                                    SizedBox(height: 180),
                                    Center(
                                      child: Text(
                                        'No users found',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: AdminTheme.textMuted,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : ListView.builder(
                                  padding:
                                      const EdgeInsets.fromLTRB(24, 8, 24, 12),
                                  itemCount: filteredUsers.length,
                                  itemBuilder: (context, index) {
                                    final user = filteredUsers[index];
                                    return _buildUserCard(user);
                                  },
                                ),
                        ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AdminBar(selectedIndex: 1),
    );
  }

  Widget _buildUserCard(Map<String, dynamic> user) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: SizedBox(
        height: 108,
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: AdminTheme.card,
                  border: Border.all(color: AdminTheme.border, width: 1),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x22000000),
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            user['name'] ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: AdminTheme.textDark,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            user['email'] ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: AdminTheme.textDark,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    _buildStatusButton(user['status'] ?? 'Active'),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            InkWell(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AdminEditUser(user: user),
                  ),
                );

                await fetchUsers();
              },
              child: const SizedBox(
                width: 24,
                child: Center(
                  child: Icon(
                    Icons.edit_outlined,
                    size: 24,
                    color: AdminTheme.textDark,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusButton(String status) {
    return Container(
      width: 92,
      height: 42,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: _statusColor(status),
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 4,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        status,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
