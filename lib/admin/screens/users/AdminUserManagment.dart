import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:releaf_app/widgets/app_top_bar.dart';

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

  bool get isDark => Theme.of(context).brightness == Brightness.dark;

  Color get cardBg => isDark ? const Color(0xFF1F2D28) : AdminTheme.card;
  Color get borderColor => isDark ? Colors.white10 : AdminTheme.border;
  Color get titleColor => isDark ? Colors.white : AdminTheme.textDark;
  Color get subTextColor => isDark ? Colors.white70 : AdminTheme.textMuted;
  Color get iconColor => isDark ? Colors.white70 : AdminTheme.textDark;
  Color get hintColor => isDark ? Colors.white54 : const Color(0xFF8A8A8A);
  Color get topBarStart =>
      isDark ? const Color(0xFF1F2D28) : AdminTheme.primary;
  Color get topBarEnd =>
      isDark ? const Color(0xFF31443B) : AdminTheme.secondary;

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
      color: cardBg,
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
      items: [
        _buildFilterMenuItem('All Users'),
        _buildFilterMenuItem('Active'),
        _buildFilterMenuItem('Inactive'),
        _buildFilterMenuItem('Blocked'),
      ],
    );

    if (selected != null) {
      updateFilter(selected);
    }
  }

  PopupMenuItem<String> _buildFilterMenuItem(String value) {
    final bool isSelected = selectedFilter == value;

    return PopupMenuItem(
      value: value,
      child: Text(
        value,
        style: TextStyle(
          color: isSelected ? AdminTheme.primary : titleColor,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
        ),
      ),
    );
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

  Widget _searchAndFilterSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: cardBg,
                    border: Border.all(color: borderColor),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(isDark ? 0.18 : 0.03),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: hintColor,
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          onChanged: searchUsers,
                          style: TextStyle(
                            color: titleColor,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Search User',
                            hintStyle: TextStyle(
                              color: hintColor,
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
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Icon(
                        Icons.tune_rounded,
                        size: 24,
                        color: iconColor,
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
              style: TextStyle(
                color: subTextColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
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
                  color: cardBg,
                  border: Border.all(
                    color: borderColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(isDark ? 0.22 : 0.12),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
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
                            style: TextStyle(
                              color: titleColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            user['email'] ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: subTextColor,
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
              child: SizedBox(
                width: 24,
                child: Center(
                  child: Icon(
                    Icons.edit_outlined,
                    size: 24,
                    color: iconColor,
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.22 : 0.12),
            blurRadius: 4,
            offset: const Offset(0, 3),
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

  @override
  Widget build(BuildContext context) {
    return AdminBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              AppTopBar(
                title: 'Users Management',
                icon: Icons.group_rounded,
                showNotifications: false,
                gradientColors: [
                  topBarStart,
                  topBarEnd,
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    _searchAndFilterSection(),
                    Expanded(
                      child: isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: AdminTheme.primary,
                              ),
                            )
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
                                          children: [
                                            const SizedBox(height: 180),
                                            Center(
                                              child: Text(
                                                'No users found',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: subTextColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : ListView.builder(
                                          padding: const EdgeInsets.fromLTRB(
                                            24,
                                            8,
                                            24,
                                            12,
                                          ),
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
            ],
          ),
        ),
        bottomNavigationBar: const AdminBar(selectedIndex: 1),
      ),
    );
  }
}
