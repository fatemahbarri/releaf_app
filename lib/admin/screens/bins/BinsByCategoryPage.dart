import 'package:flutter/material.dart';

import '../../../services/firebase_service.dart';
import '../../theme/admin_theme.dart';
import '../../widgets/admin_background.dart';
import 'AddBin.dart';
import '../home/AdminHomePage.dart';
import '../users/AdminUserManagment.dart';
import '../reports/AdminReportIssue.dart';
import '../profile/AdminProfile.dart';
import 'AdminBinsPage.dart';

class BinsByCategoryPage extends StatefulWidget {
  final String category;

  const BinsByCategoryPage({
    super.key,
    required this.category,
  });

  @override
  State<BinsByCategoryPage> createState() => _BinsByCategoryPageState();
}

class _BinsByCategoryPageState extends State<BinsByCategoryPage> {
  final TextEditingController _searchController = TextEditingController();
  final FirebaseService _firebaseService = FirebaseService();

  List<Map<String, dynamic>> _bins = [];
  bool _isLoading = true;

  static const Color primary = Color(0xFF7FB77E);
  static const Color secondary = Color(0xFF5E9C76);
  static const Color lightGreen = Color(0xFFEAF6E3);
  static const Color border = Color(0xFFDCE8D7);
  static const Color textDark = Color(0xFF2F5D50);
  static const Color textMedium = Color(0xFF4E6A57);

  bool get isDark => Theme.of(context).brightness == Brightness.dark;

  Color get cardBg => isDark ? const Color(0xFF1F2D28) : Colors.white;
  Color get iconBoxBg => isDark ? const Color(0xFF31443B) : lightGreen;
  Color get borderColor => isDark ? Colors.white10 : border;
  Color get titleColor => isDark ? Colors.white : textDark;
  Color get subTextColor => isDark ? Colors.white70 : textMedium;
  Color get hintColor => isDark ? Colors.white54 : const Color(0xFF8A9A8C);
  Color get bottomBarBg => isDark ? const Color(0xFF1F2D28) : lightGreen;
  Color get selectedNavBg =>
      isDark ? Colors.white.withOpacity(0.10) : primary.withOpacity(0.25);

  @override
  void initState() {
    super.initState();
    _loadBins();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadBins() async {
    setState(() => _isLoading = true);

    try {
      final bins = await _firebaseService.getBinsByType(
        category: widget.category,
        isActive: true,
      );

      if (!mounted) return;

      setState(() => _bins = bins);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  List<Map<String, dynamic>> get filtered {
    final query = _searchController.text.trim().toLowerCase();

    return _bins.where((bin) {
      return query.isEmpty ||
          (bin['binName'] ?? '').toString().toLowerCase().contains(query) ||
          (bin['city'] ?? '').toString().toLowerCase().contains(query) ||
          (bin['Region'] ?? '').toString().toLowerCase().contains(query) ||
          (bin['Description'] ?? '').toString().toLowerCase().contains(query);
    }).toList();
  }

  Future<void> _delete(Map<String, dynamic> bin) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: cardBg,
        title: Text(
          'Delete Bin',
          style: TextStyle(
            color: titleColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Delete "${bin['binName']}"?',
          style: TextStyle(color: subTextColor),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              'Cancel',
              style: TextStyle(color: subTextColor),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () => Navigator.pop(context, true),
            icon: const Icon(Icons.delete, color: Colors.white),
            label: const Text('Delete'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AdminTheme.error,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      await _firebaseService.deleteBin(bin['id'].toString());
      await _loadBins();
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  Future<void> _add() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddBin(category: widget.category),
      ),
    );

    if (result == true) {
      await _loadBins();
    }
  }

  Future<void> _edit(Map<String, dynamic> bin) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddBin(
          category: widget.category,
          initialData: bin,
        ),
      ),
    );

    if (result == true) {
      await _loadBins();
    }
  }

  void _onBottomTap(int index) {
    if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AdminBinsPage()),
      );
    } else if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const AdminHomePage(adminName: 'Admin'),
        ),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AdminUserManagment()),
      );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AdminReportIssue()),
      );
    } else if (index == 4) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AdminProfile()),
      );
    }
  }

  Widget _topBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? const [
                  Color(0xFF1F2D28),
                  Color(0xFF31443B),
                ]
              : const [
                  primary,
                  secondary,
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.vertical(
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
              Icons.location_on_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '${widget.category} Bins',
              style: const TextStyle(
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

  Widget _searchField() {
    return TextField(
      controller: _searchController,
      onChanged: (_) => setState(() {}),
      style: TextStyle(
        color: titleColor,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        hintText: 'Search Location',
        hintStyle: TextStyle(color: hintColor),
        prefixIcon: Icon(
          Icons.search,
          color: subTextColor,
        ),
        filled: true,
        fillColor: cardBg,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: const BorderSide(
            color: primary,
            width: 1.4,
          ),
        ),
      ),
    );
  }

  Widget _buildBinCard(Map<String, dynamic> bin) {
    final subtitle =
        '${bin['city'] ?? ''}${(bin['Region'] ?? '').toString().isNotEmpty ? ' - ${bin['Region']}' : ''}';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.20 : 0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: iconBoxBg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              Icons.location_on_outlined,
              color: isDark ? Colors.white : textDark,
              size: 26,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bin['binName']?.toString() ?? '',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: titleColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13.5,
                    color: subTextColor,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  bin['Description']?.toString() ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.5,
                    color: subTextColor,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            children: [
              _smallActionButton(
                icon: Icons.edit_outlined,
                onTap: () => _edit(bin),
                color: secondary,
              ),
              const SizedBox(height: 8),
              _smallActionButton(
                icon: Icons.delete_outline,
                onTap: () => _delete(bin),
                color: AdminTheme.error,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _smallActionButton({
    required IconData icon,
    required VoidCallback onTap,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.25),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildBottomNavItem({
    required IconData icon,
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: selected ? selectedNavBg : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  icon,
                  color: selected ? titleColor : subTextColor,
                  size: 27,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: selected ? titleColor : subTextColor,
                  fontWeight: selected ? FontWeight.bold : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(22),
      ),
      child: Container(
        color: bottomBarBg,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        child: Row(
          children: [
            _buildBottomNavItem(
              icon: Icons.home_outlined,
              label: 'Home',
              selected: false,
              onTap: () => _onBottomTap(0),
            ),
            _buildBottomNavItem(
              icon: Icons.group_outlined,
              label: 'Users',
              selected: false,
              onTap: () => _onBottomTap(1),
            ),
            _buildBottomNavItem(
              icon: Icons.location_on_outlined,
              label: 'Bins',
              selected: true,
              onTap: () => _onBottomTap(2),
            ),
            _buildBottomNavItem(
              icon: Icons.report_problem_outlined,
              label: 'Issues',
              selected: false,
              onTap: () => _onBottomTap(3),
            ),
            _buildBottomNavItem(
              icon: Icons.settings_outlined,
              label: 'Profile',
              selected: false,
              onTap: () => _onBottomTap(4),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final list = filtered;

    return AdminBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _topBar(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 18, 16, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _searchField(),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Nearby Locations',
                            style: TextStyle(
                              color: titleColor,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: _add,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [primary, secondary],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(22),
                                boxShadow: [
                                  BoxShadow(
                                    color: primary.withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    'Add Bin',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: _isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: secondary,
                                ),
                              )
                            : list.isEmpty
                                ? Center(
                                    child: Text(
                                      'No locations found',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: subTextColor,
                                      ),
                                    ),
                                  )
                                : ListView(
                                    children: list.map(_buildBinCard).toList(),
                                  ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomBar(),
      ),
    );
  }
}
