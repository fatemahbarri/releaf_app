import 'package:flutter/material.dart';
import 'AddBin.dart';
import '../services/firebase_service.dart';

class AdminBinManagment2 extends StatefulWidget {
  final String category;

  const AdminBinManagment2({
    super.key,
    required this.category,
  });

  @override
  State<AdminBinManagment2> createState() => _AdminBinManagment2State();
}

class _AdminBinManagment2State extends State<AdminBinManagment2> {
  final TextEditingController _searchController = TextEditingController();
  final FirebaseService _firebaseService = FirebaseService();

  List<Map<String, dynamic>> _bins = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBins();
  }

  Future<void> _loadBins() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final bins = await _firebaseService.getBinsByType(widget.category);
      if (!mounted) return;

      setState(() {
        _bins = bins;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  List<Map<String, dynamic>> get filtered {
    final query = _searchController.text.trim().toLowerCase();

    return _bins.where((b) {
      final matchesSearch = query.isEmpty ||
          (b['binName'] ?? '').toString().toLowerCase().contains(query) ||
          (b['city'] ?? '').toString().toLowerCase().contains(query) ||
          (b['Region'] ?? '').toString().toLowerCase().contains(query) ||
          (b['Description'] ?? '').toString().toLowerCase().contains(query);

      return matchesSearch;
    }).toList();
  }

  Future<void> _delete(Map<String, dynamic> bin) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Bin'),
        content: Text('Delete "${bin['binName']}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);

              try {
                await _firebaseService.deleteBin(bin['id'].toString());
                await _loadBins();
              } catch (e) {
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(e.toString())),
                );
              }
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
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
              color: const Color(0xFFF8F8F8),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFF9A9A9A)),
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
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          bin['Description']?.toString() ?? '',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
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
                    color: const Color(0xFFB8D67D),
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
                      color: Colors.black87,
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
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavItem({
    required IconData icon,
    required String label,
    required bool selected,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                color: selected ? const Color(0xFFA8C89B) : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF2B2B2B),
                size: 28,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: selected
                    ? const Color(0xFF5A4A73)
                    : const Color(0xFF2B2B2B),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final list = filtered;

    return Scaffold(
      backgroundColor: const Color(0xFFF3FFE2),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 22, 24, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Color(0xFF675F5A),
                            size: 28,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: const Color(0xFFC7DBBD),
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x22000000),
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Text(
                              widget.category,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: const Color(0xFFD8D8D8),
                              ),
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
                                  color: Colors.black87,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        const Icon(
                          Icons.filter_alt_outlined,
                          size: 34,
                          color: Colors.black87,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (_isLoading)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 40),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    else if (list.isEmpty)
                      const Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: Center(
                          child: Text(
                            'No locations found',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      )
                    else
                      ...list.map(_buildBinCard),
                    const SizedBox(height: 55),
                    Center(
                      child: SizedBox(
                        width: 230,
                        height: 64,
                        child: ElevatedButton(
                          onPressed: _add,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFB8D67D),
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
                              color: Color(0xFF5B5554),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            Container(
              color: const Color(0xFFCDE9C7),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                children: [
                  _buildBottomNavItem(
                    icon: Icons.home_outlined,
                    label: 'Home',
                    selected: false,
                  ),
                  _buildBottomNavItem(
                    icon: Icons.groups_outlined,
                    label: 'Users',
                    selected: false,
                  ),
                  _buildBottomNavItem(
                    icon: Icons.location_on_outlined,
                    label: 'Bins',
                    selected: true,
                  ),
                  _buildBottomNavItem(
                    icon: Icons.settings_outlined,
                    label: 'Profile',
                    selected: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
