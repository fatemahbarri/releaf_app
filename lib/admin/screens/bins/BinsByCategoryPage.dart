import 'package:flutter/material.dart';

import '../../../services/firebase_service.dart';
import '../../widgets/AdminBar.dart';
import '../../widgets/admin_background.dart';
import '../../widgets/admin_header.dart';
import '../../theme/admin_theme.dart';
import 'AddBin.dart';

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
      final bins = await _firebaseService.getBinsByType(widget.category);

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
        title: const Text('Delete Bin'),
        content: Text('Delete "${bin['binName']}"?'),
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

  Widget _buildBinCard(Map<String, dynamic> bin) {
    final subtitle =
        '${bin['city'] ?? ''}${(bin['Region'] ?? '').toString().isNotEmpty ? ' - ${bin['Region']}' : ''}';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 18),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            decoration: BoxDecoration(
              color: AdminTheme.card,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AdminTheme.border),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x22000000),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bin['binName']?.toString() ?? '',
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: AdminTheme.textDark,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AdminTheme.textDark,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          bin['Description']?.toString() ?? '',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AdminTheme.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 64,
                  height: 42,
                  decoration: BoxDecoration(
                    color: AdminTheme.primary,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x22000000),
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: () => _edit(bin),
                    icon: const Icon(
                      Icons.edit_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Padding(
          padding: const EdgeInsets.only(bottom: 18),
          child: IconButton(
            onPressed: () => _delete(bin),
            icon: const Icon(
              Icons.delete_outline,
              size: 34,
              color: AdminTheme.error,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final list = filtered;

    return Scaffold(
      body: AdminBackground(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 22, 24, 0),
              child: AdminHeader(
                title: widget.category,
                showBack: true,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AdminTheme.card,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AdminTheme.border),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (_) => setState(() {}),
                        decoration: const InputDecoration(
                          hintText: 'Search Location',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.search,
                      color: AdminTheme.textDark,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : list.isEmpty
                      ? const Center(
                          child: Text(
                            'No locations found',
                            style: TextStyle(
                              fontSize: 16,
                              color: AdminTheme.textMuted,
                            ),
                          ),
                        )
                      : ListView(
                          padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                          children: list.map(_buildBinCard).toList(),
                        ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: SizedBox(
                width: 230,
                height: 64,
                child: ElevatedButton(
                  onPressed: _add,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AdminTheme.primary,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Add Bin',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AdminBar(selectedIndex: 2),
    );
  }
}
