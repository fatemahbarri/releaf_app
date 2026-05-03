import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:releaf_app/widgets/app_top_bar.dart';

import '../../widgets/AdminBar.dart';
import '../../widgets/admin_background.dart';
import '../../theme/admin_theme.dart';
import 'AddBin.dart';

class AdminBinsPage extends StatefulWidget {
  const AdminBinsPage({super.key});

  @override
  State<AdminBinsPage> createState() => _AdminBinsPageState();
}

class _AdminBinsPageState extends State<AdminBinsPage> {
  String _selectedFilter = 'All';
  String _selectedStatus = 'Active';

  static const Color primary = AdminTheme.primary;
  static const Color secondary = AdminTheme.secondary;
  static const Color lightGreen = AdminTheme.background;
  static const Color border = AdminTheme.border;
  static const Color textDark = AdminTheme.textDark;
  static const Color textMedium = AdminTheme.textMedium;

  bool get isDark => Theme.of(context).brightness == Brightness.dark;

  Color get cardBg => isDark ? const Color(0xFF1F2D28) : Colors.white;
  Color get chipBg => isDark ? const Color(0xFF263A32) : Colors.white;
  Color get iconBoxBg => isDark ? const Color(0xFF31443B) : lightGreen;
  Color get borderColor => isDark ? Colors.white10 : border;
  Color get titleColor => isDark ? Colors.white : textDark;
  Color get subTextColor => isDark ? Colors.white70 : textMedium;
  Color get topBarStart => isDark ? const Color(0xFF1F2D28) : primary;
  Color get topBarEnd => isDark ? const Color(0xFF31443B) : secondary;

  Stream<QuerySnapshot<Map<String, dynamic>>> _getBinsStream() {
    return FirebaseFirestore.instance.collection('bins').snapshots();
  }

  String _getValue(
    Map<String, dynamic> data,
    List<String> keys, {
    String fallback = '',
  }) {
    for (final key in keys) {
      if (data.containsKey(key) && data[key] != null) {
        final value = data[key].toString().trim();
        if (value.isNotEmpty) return value;
      }
    }
    return fallback;
  }

  bool _isActiveBin(Map<String, dynamic> data) {
    final value = data['isActive'];

    if (value is bool) return value;

    if (value is String) {
      return value.toLowerCase() == 'active';
    }

    return true;
  }

  List<QueryDocumentSnapshot<Map<String, dynamic>>> _filterBins(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> bins,
  ) {
    return bins.where((doc) {
      final data = doc.data();

      final isActive = _isActiveBin(data);
      if (_selectedStatus == 'Active' && !isActive) return false;
      if (_selectedStatus == 'Inactive' && isActive) return false;

      if (_selectedFilter == 'All') return true;

      final type = _getValue(
        data,
        ['type', 'category', 'material', 'binType'],
      ).toLowerCase();

      return type == _selectedFilter.toLowerCase();
    }).toList();
  }

  Future<void> _editBin(String binId, Map<String, dynamic> bin) async {
    final type = _getValue(
      bin,
      ['type', 'category', 'material', 'binType'],
      fallback: 'Plastic',
    );

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddBin(
          category: type,
          initialData: {
            'id': binId,
            ...bin,
          },
        ),
      ),
    );
  }

  Future<void> _deleteBin(String binId, String binName) async {
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
          'Delete "$binName"?',
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

    await FirebaseFirestore.instance.collection('bins').doc(binId).delete();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Bin deleted successfully')),
    );
  }

  Widget _buildStatusTab(String text) {
    final selected = _selectedStatus == text;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedStatus = text;
          });
        },
        child: Container(
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? primary : chipBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? primary : borderColor,
            ),
            boxShadow: [
              if (!selected)
                BoxShadow(
                  color: Colors.black.withOpacity(isDark ? 0.18 : 0.04),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
            ],
          ),
          child: Text(
            text == 'Active' ? 'Active Bins' : 'Inactive Bins',
            style: TextStyle(
              color: selected ? Colors.white : subTextColor,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterButton(String text) {
    final selected = _selectedFilter == text;

    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = text),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? primary : chipBg,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: selected ? primary : borderColor,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selected ? Colors.white : subTextColor,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildBinIcon(String type) {
    final t = type.toLowerCase();

    String? imagePath;

    if (t == 'plastic') {
      imagePath = 'assets/images/plastic-bottle.png';
    } else if (t == 'metal') {
      imagePath = 'assets/images/can.png';
    } else if (t == 'paper') {
      imagePath = 'assets/images/paper.png';
    } else if (t == 'glass') {
      imagePath = 'assets/images/glass.png';
    } else if (t == 'cardboard') {
      imagePath = 'assets/images/cardboard.png';
    } else if (t == 'trash') {
      imagePath = 'assets/images/trash.png';
    }

    if (imagePath != null) {
      return Image.asset(
        imagePath,
        width: 27,
        height: 27,
        fit: BoxFit.contain,
      );
    }

    return Icon(
      Icons.delete_outline,
      color: titleColor,
      size: 24,
    );
  }

  Widget _actionButton({
    required IconData icon,
    required VoidCallback onTap,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 37,
        height: 37,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(18.5),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.25),
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: 19),
      ),
    );
  }

  Widget _buildBinCard(String binId, Map<String, dynamic> bin) {
    final name = _getValue(
      bin,
      ['name', 'binName', 'title', 'locationName'],
      fallback: 'Recycling Bin',
    );

    final type = _getValue(
      bin,
      ['type', 'category', 'material', 'binType'],
      fallback: 'Unknown',
    );

    final city = _getValue(
      bin,
      ['city', 'area', 'location', 'address'],
    );

    final province = _getValue(
      bin,
      ['province', 'region'],
    );

    final materials = _getValue(
      bin,
      ['acceptedMaterials', 'materials', 'accepted'],
    );

    final locationText = [
      city,
      province,
    ].where((e) => e.trim().isNotEmpty).join(' - ');

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
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: iconBoxBg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(child: _buildBinIcon(type)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: titleColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                if (locationText.isNotEmpty)
                  Text(
                    locationText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: subTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                if (materials.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    materials,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: subTextColor,
                      fontSize: 11.5,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            children: [
              _actionButton(
                icon: Icons.edit,
                onTap: () => _editBin(binId, bin),
                color: secondary,
              ),
              const SizedBox(height: 8),
              _actionButton(
                icon: Icons.delete_outline,
                onTap: () => _deleteBin(binId, name),
                color: AdminTheme.error,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _addNewBin() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AddBin(category: 'Plastic'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AdminBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: GestureDetector(
          onTap: _addNewBin,
          child: Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [primary, secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: primary.withOpacity(0.4),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              AppTopBar(
                title: 'Bins',
                icon: Icons.location_on_rounded,
                showNotifications: false,
                gradientColors: [
                  topBarStart,
                  topBarEnd,
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          _buildStatusTab('Active'),
                          const SizedBox(width: 10),
                          _buildStatusTab('Inactive'),
                        ],
                      ),
                      const SizedBox(height: 14),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildFilterButton('All'),
                            const SizedBox(width: 8),
                            _buildFilterButton('Plastic'),
                            const SizedBox(width: 8),
                            _buildFilterButton('Paper'),
                            const SizedBox(width: 8),
                            _buildFilterButton('Metal'),
                            const SizedBox(width: 8),
                            _buildFilterButton('Glass'),
                            const SizedBox(width: 8),
                            _buildFilterButton('Cardboard'),
                            const SizedBox(width: 8),
                            _buildFilterButton('Trash'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child:
                            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: _getBinsStream(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: secondary,
                                ),
                              );
                            }

                            if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                  'Failed to load bins',
                                  style: TextStyle(
                                    color: subTextColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }

                            final bins = _filterBins(snapshot.data?.docs ?? []);

                            if (bins.isEmpty) {
                              return Center(
                                child: Text(
                                  _selectedStatus == 'Active'
                                      ? 'No active bins found'
                                      : 'No inactive bins found',
                                  style: TextStyle(
                                    color: subTextColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }

                            return ListView.builder(
                              itemCount: bins.length,
                              itemBuilder: (context, index) {
                                final doc = bins[index];

                                return _buildBinCard(
                                  doc.id,
                                  doc.data(),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const AdminBar(selectedIndex: 2),
      ),
    );
  }
}
