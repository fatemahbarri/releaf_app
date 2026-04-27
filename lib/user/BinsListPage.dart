import 'package:flutter/material.dart';

import 'package:releaf_app/widgets/app_background.dart';
import 'package:releaf_app/widgets/releaf_ui.dart';

import 'package:releaf_app/user/HomePageUser.dart';
import 'package:releaf_app/user/LocationPage.dart';
import 'package:releaf_app/user/Profile.dart';
import 'package:releaf_app/classification/image_classifier_screen.dart';

import 'BinDetailsPage.dart';
import '../services/firebase_service.dart';

class BinsListPage extends StatefulWidget {
  final String category;

  const BinsListPage({
    super.key,
    required this.category,
  });

  @override
  State<BinsListPage> createState() => _BinsListPageState();
}

class _BinsListPageState extends State<BinsListPage> {
  final TextEditingController _searchController = TextEditingController();
  final FirebaseService _firebaseService = FirebaseService();

  List<Map<String, dynamic>> _bins = [];
  bool _isLoading = true;
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _loadBins();
  }

  Future<void> _loadBins() async {
    setState(() => _isLoading = true);

    try {
      final bins = await _firebaseService.getBinsByType(widget.category);

      if (!mounted) return;

      setState(() {
        _bins = bins;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() => _isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  List<Map<String, dynamic>> get _filteredBins {
    final query = _searchText.trim().toLowerCase();

    return _bins.where((bin) {
      return query.isEmpty ||
          (bin['binName'] ?? '').toString().toLowerCase().contains(query) ||
          (bin['city'] ?? '').toString().toLowerCase().contains(query) ||
          (bin['Region'] ?? '').toString().toLowerCase().contains(query) ||
          (bin['Description'] ?? '').toString().toLowerCase().contains(query);
    }).toList();
  }

  void _handleGo(Map<String, dynamic> bin) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BinDetailsPage(
          locationName: bin['binName'] ?? '',
          address: '${bin['city'] ?? ''} ${bin['Region'] ?? ''}',
          category: bin['binType'] ?? '',
          latitude: (bin['latitude'] ?? 0).toDouble(),
          longitude: (bin['longitude'] ?? 0).toDouble(),
        ),
      ),
    );
  }

  void _onBottomTap(int index) {
    if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LocationPage(),
        ),
      );
    }

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomePageUser(),
        ),
      );
    }

    if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const ImageClassifierScreen(),
        ),
      );
    }

    if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const Profile(
            name: 'User',
            email: 'user@email.com',
          ),
        ),
      );
    }
  }

  Widget _buildLocationCard(Map<String, dynamic> bin) {
    return ReLeafCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: ReLeafColors.lightGreen,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.location_on_outlined,
              color: ReLeafColors.textDark,
              size: 26,
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bin['binName'] ?? '',
                  style: ReLeafTextStyles.title.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  '${bin['city'] ?? ''} ${bin['Region'] ?? ''}',
                  style: ReLeafTextStyles.body,
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          ReLeafButton(
            text: 'Go',
            small: true,
            icon: Icons.arrow_forward_rounded,
            onPressed: () => _handleGo(bin),
          ),
        ],
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
    final isTrash = widget.category.toLowerCase() == 'trash';

    final pageTitle = isTrash ? 'Trash Bins' : '${widget.category} Bins';

    final pageSubtitle =
        isTrash ? 'Non-recyclable waste locations' : 'Available recycling bins';

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              ReLeafHeader(
                title: pageTitle,
                subtitle: pageSubtitle,
                icon: Icons.location_on_rounded,
                showBackButton: true,
                onBack: () => Navigator.pop(context),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 18, 16, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReLeafSearchBar(
                        controller: _searchController,
                        hintText: 'Search location',
                        onChanged: (value) {
                          setState(() => _searchText = value);
                        },
                      ),

                      const SizedBox(height: 16),

                      Text(
                        'Nearby Locations',
                        style: ReLeafTextStyles.title.copyWith(fontSize: 22),
                      ),

                      const SizedBox(height: 12),

                      Expanded(
                        child: _isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: ReLeafColors.secondary,
                                ),
                              )
                            : _filteredBins.isEmpty
                                ? const Center(
                                    child: ReLeafInfoBox(
                                      text:
                                          'No locations available for this category yet.',
                                      icon: Icons.info_outline,
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: _filteredBins.length,
                                    itemBuilder: (context, index) {
                                      return _buildLocationCard(
                                        _filteredBins[index],
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

        bottomNavigationBar: ReLeafBottomBar(
          selectedIndex: 2,
          onTap: _onBottomTap,
        ),
      ),
    );
  }
}