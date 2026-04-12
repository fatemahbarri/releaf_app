import 'package:flutter/material.dart';
import 'AdminBar.dart';
import 'AdminHomePage.dart';
import 'AdminEditUser.dart';

class AdminUserManagment extends StatefulWidget {
  const AdminUserManagment({super.key});

  @override
  State<AdminUserManagment> createState() => _AdminUserManagmentState();
}

class _AdminUserManagmentState extends State<AdminUserManagment> {
  final TextEditingController searchController = TextEditingController();

  final List<Map<String, String>> allUsers = [
    {'name': 'Sara Abdullah', 'email': 'sara@gmail.com', 'status': 'Active'},
    {'name': 'Mona Ali', 'email': 'mona@gmail.com', 'status': 'Inactive'},
    {'name': 'Nora Saad', 'email': 'nora@gmail.com', 'status': 'Active'},
  ];

  List<Map<String, String>> filteredUsers = [];
  String selectedFilter = 'All Users';

  @override
  void initState() {
    super.initState();
    applyFilters();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void applyFilters() {
    final query = searchController.text.toLowerCase().trim();

    setState(() {
      filteredUsers = allUsers.where((user) {
        final name = (user['name'] ?? '').toLowerCase();
        final email = (user['email'] ?? '').toLowerCase();
        final status = (user['status'] ?? '').toLowerCase();

        final matchesSearch =
            query.isEmpty || name.contains(query) || email.contains(query);

        final matchesFilter = selectedFilter == 'All Users' ||
            status == selectedFilter.toLowerCase();

        return matchesSearch && matchesFilter;
      }).toList();
    });
  }

  void searchUsers(String value) {
    applyFilters();
  }

  void updateFilter(String filter) {
    selectedFilter = filter;
    applyFilters();
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
      ],
    );

    if (selected != null) {
      updateFilter(selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3FFE2),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: const Color(0xFFF3FFE2),
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
              child: Column(
                children: [
                  SizedBox(
                    height: 32,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AdminHomePage(adminName: 'Admin'),
                                ),
                              );
                            },
                            child: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.black,
                              size: 24,
                            ),
                          ),
                        ),
                        const Center(
                          child: Text(
                            'Users Management',
                            style: TextStyle(
                              color: Color(0xFF7CA385),
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: const Color(0xFFB0B0B0).withOpacity(0.6),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 48,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: const Color(0xFFD9D9D9)),
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
                                      color: Color(0xFFB3B3B3),
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
                                color: Color(0xFF4D4D4D),
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
                        color: Color(0xFF5F5F5F),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: filteredUsers.isEmpty
                  ? const Center(
                      child: Text(
                        'No users found',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF666666),
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(24, 8, 24, 12),
                      itemCount: filteredUsers.length,
                      itemBuilder: (context, index) {
                        final user = filteredUsers[index];
                        return _buildUserCard(user);
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AdminBar(selectedIndex: 1),
    );
  }

  Widget _buildUserCard(Map<String, String> user) {
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
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFF989898), width: 1),
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
                              color: Colors.black,
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
                              color: Colors.black,
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminEditUser(user: user),
                  ),
                );
              },
              child: const SizedBox(
                width: 24,
                child: Center(
                  child: Icon(
                    Icons.edit_outlined,
                    size: 24,
                    color: Color(0xFF4D4D4D),
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
    Color backgroundColor;

    if (status == 'Active') {
      backgroundColor = const Color(0xFF7ACD0E);
    } else if (status == 'Inactive') {
      backgroundColor = const Color(0xFFE47D0F);
    } else {
      backgroundColor = const Color(0xFFD00000);
    }

    return Container(
      width: 92,
      height: 42,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor,
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
