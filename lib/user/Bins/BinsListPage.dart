import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:releaf_app/l10n/app_localizations.dart';

import 'package:releaf_app/widgets/app_background.dart';
import 'package:releaf_app/widgets/app_top_bar.dart';
import 'package:releaf_app/widgets/releaf_ui.dart';
import 'package:releaf_app/user/UserWidgets/UserBottomNav.dart';

import 'package:releaf_app/user/Home/HomePageUser.dart';
import 'package:releaf_app/user/Bins/LocationPage.dart';
import 'package:releaf_app/user/profile/Profile.dart';
import 'package:releaf_app/user/classification/image_classifier_screen.dart';

import 'BinDetailsPage.dart';

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
  String _searchText = '';

  bool get isDarkMode => Theme.of(context).brightness == Brightness.dark;

  Color get cardColor =>
      isDarkMode ? const Color(0xFF1F2F2A) : Colors.white.withOpacity(0.96);

  Color get iconBoxColor =>
      isDarkMode ? const Color(0xFF2E4A3D) : ReLeafColors.lightGreen;

  Color get mainTextColor => isDarkMode ? Colors.white : ReLeafColors.textDark;

  Color get subTextColor =>
      isDarkMode ? Colors.white70 : ReLeafColors.textDark.withOpacity(0.65);

  Color get borderColor => isDarkMode
      ? Colors.white.withOpacity(0.08)
      : Colors.white.withOpacity(0.8);

  Color get shadowColor => isDarkMode
      ? Colors.black.withOpacity(0.25)
      : Colors.black.withOpacity(0.06);

  List<Color> get topBarGradient => isDarkMode
      ? const [
          Color(0xFF1B3A31),
          Color(0xFF2F5D50),
        ]
      : const [
          Color(0xFF7FB77E),
          Color(0xFF5E9C76),
        ];

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
      final v = value.toLowerCase().trim();
      return v == 'active' || v == 'true';
    }

    return false;
  }

  List<QueryDocumentSnapshot<Map<String, dynamic>>> _filterBins(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> bins,
  ) {
    final selectedCategory = widget.category.toLowerCase().trim();
    final query = _searchText.toLowerCase().trim();

    return bins.where((doc) {
      final data = doc.data();

      final isActive = _isActiveBin(data);
      if (!isActive) return false;

      final type = _getValue(
        data,
        ['binType', 'type', 'category', 'material'],
      ).toLowerCase().trim();

      if (type != selectedCategory) return false;

      final name = _getValue(
        data,
        ['binName', 'name', 'title', 'locationName'],
      ).toLowerCase();

      final city = _getValue(
        data,
        ['city', 'area', 'location', 'address'],
      ).toLowerCase();

      final region = _getValue(
        data,
        ['Region', 'region', 'province'],
      ).toLowerCase();

      final description = _getValue(
        data,
        ['Description', 'description', 'details'],
      ).toLowerCase();

      return query.isEmpty ||
          name.contains(query) ||
          city.contains(query) ||
          region.contains(query) ||
          description.contains(query);
    }).toList();
  }

  double _getDoubleValue(Map<String, dynamic> data, List<String> keys) {
    for (final key in keys) {
      final value = data[key];

      if (value is int) return value.toDouble();
      if (value is double) return value;
      if (value is String) return double.tryParse(value) ?? 0.0;
    }

    return 0.0;
  }

  void _handleGo(Map<String, dynamic> bin, AppLocalizations l10n) {
    final name = _getValue(
      bin,
      ['binName', 'name', 'title', 'locationName'],
      fallback: l10n.defaultBinName,
    );

    final city = _getValue(
      bin,
      ['city', 'area', 'location', 'address'],
    );

    final region = _getValue(
      bin,
      ['Region', 'region', 'province'],
    );

    final type = _getValue(
      bin,
      ['binType', 'type', 'category', 'material'],
      fallback: widget.category,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BinDetailsPage(
          locationName: name,
          address: '$city $region',
          category: type,
          latitude: _getDoubleValue(bin, ['latitude', 'lat']),
          longitude: _getDoubleValue(bin, ['longitude', 'lng', 'long']),
        ),
      ),
    );
  }

  void _onBottomTap(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePageUser()),
      );
    }

    if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ImageClassifierScreen()),
      );
    }

    if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LocationPage()),
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

  Widget _customCard({
    required Widget child,
    EdgeInsetsGeometry padding = const EdgeInsets.all(14),
    EdgeInsetsGeometry margin = const EdgeInsets.only(bottom: 12),
  }) {
    return Container(
      width: double.infinity,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _searchBar(AppLocalizations l10n) {
    return Container(
      height: 54,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          setState(() => _searchText = value);
        },
        cursorColor: ReLeafColors.secondary,
        style: TextStyle(
          color: mainTextColor,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          icon: Icon(
            Icons.search_rounded,
            color: isDarkMode ? Colors.white70 : ReLeafColors.primary,
          ),
          hintText: l10n.binsSearchLocation,
          hintStyle: TextStyle(
            color: subTextColor,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _infoBox({
    required String text,
    required IconData icon,
    bool isError = false,
  }) {
    return _customCard(
      margin: EdgeInsets.zero,
      child: Row(
        children: [
          Icon(
            icon,
            color: isError
                ? Colors.red
                : isDarkMode
                    ? Colors.white70
                    : ReLeafColors.primary,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: ReLeafTextStyles.body.copyWith(
                color: isError ? Colors.red : subTextColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationCard(Map<String, dynamic> bin, AppLocalizations l10n) {
    final name = _getValue(
      bin,
      ['binName', 'name', 'title', 'locationName'],
      fallback: l10n.defaultBinName,
    );

    final city = _getValue(
      bin,
      ['city', 'area', 'location', 'address'],
    );

    final region = _getValue(
      bin,
      ['Region', 'region', 'province'],
    );

    return _customCard(
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: iconBoxColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              Icons.location_on_outlined,
              color: isDarkMode ? Colors.white70 : ReLeafColors.textDark,
              size: 26,
            ),
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
                  style: ReLeafTextStyles.title.copyWith(
                    fontSize: 14,
                    color: mainTextColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$city $region',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: ReLeafTextStyles.body.copyWith(
                    color: subTextColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          ReLeafButton(
            text: l10n.binsGo,
            small: true,
            icon: Icons.arrow_forward_rounded,
            onPressed: () => _handleGo(bin, l10n),
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
    final l10n = AppLocalizations.of(context)!;

    final isTrash = widget.category.toLowerCase() == 'trash';

    final pageTitle = isTrash
        ? l10n.trashBinsTitle
        : l10n.categoryBinsTitle(_translateCategory(widget.category, l10n));
    final pageSubtitle =
        isTrash ? l10n.trashBinsSubtitle : l10n.recyclingBinsSubtitle;

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              AppTopBar(
                title: pageTitle,
                subtitle: pageSubtitle,
                icon: Icons.location_on_rounded,
                showBackButton: true,
                showNotifications: false,
                gradientColors: topBarGradient,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 18, 16, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _searchBar(l10n),
                      const SizedBox(height: 16),
                      Text(
                        l10n.binsNearbyLocations,
                        style: ReLeafTextStyles.title.copyWith(
                          fontSize: 22,
                          color: mainTextColor,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child:
                            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: _getBinsStream(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: ReLeafColors.secondary,
                                ),
                              );
                            }

                            if (snapshot.hasError) {
                              return Center(
                                child: _infoBox(
                                  text: l10n.binsLoadFailed,
                                  icon: Icons.error_outline,
                                  isError: true,
                                ),
                              );
                            }

                            final bins = _filterBins(snapshot.data?.docs ?? []);

                            if (bins.isEmpty) {
                              return Center(
                                child: _infoBox(
                                  text: l10n.binsNoLocations,
                                  icon: Icons.info_outline,
                                ),
                              );
                            }

                            return ListView.builder(
                              itemCount: bins.length,
                              itemBuilder: (context, index) {
                                return _buildLocationCard(
                                  bins[index].data(),
                                  l10n,
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
        bottomNavigationBar: const UserBottomNav(
          currentIndex: 2,
        ),
      ),
    );
  }

  String _translateCategory(String category, AppLocalizations l10n) {
    switch (category.toLowerCase()) {
      case 'plastic':
        return l10n.locationCategoryPlastic;
      case 'glass':
        return l10n.locationCategoryGlass;
      case 'metal':
        return l10n.locationCategoryMetal;
      case 'paper':
        return l10n.locationCategoryPaper;
      case 'cardboard':
        return l10n.locationCategoryCardboard;
      case 'trash':
        return l10n.locationCategoryTrash;
      default:
        return category;
    }
  }
}
