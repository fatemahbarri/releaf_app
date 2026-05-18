import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:releaf_app/l10n/app_localizations.dart';
import 'package:releaf_app/user/UserWidgets/UserBottomNav.dart';
import 'package:releaf_app/widgets/app_background.dart';
import 'package:releaf_app/widgets/app_top_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../widgets/releaf_ui.dart';

import 'BinsListPage.dart';
import '../Home/HomePageUser.dart';
import '../profile/Profile.dart';
import '../classification/image_classifier_screen.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final MapController _mapController = MapController();

  LatLng _currentCenter = const LatLng(26.385046, 50.189002);

  Future<void> _openGoogleMaps(double latitude, double longitude) async {
    final Uri url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude',
    );

    await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
  }

  bool _isLoadingLocation = true;
  List<Marker> _markers = [];

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

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadNearbyBins();
    });
  }

  Future<void> _loadNearbyBins() async {
    final l = AppLocalizations.of(context)!;

    try {
      setState(() => _isLoadingLocation = true);

      final serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        _showError(l.locationServiceDisabled);
        setState(() => _isLoadingLocation = false);
        return;
      }

      var permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
        _showError(l.locationPermissionRequired);
        setState(() => _isLoadingLocation = false);
        return;
      }

      if (permission == LocationPermission.deniedForever) {
        _showError(l.locationPermissionDenied);
        setState(() => _isLoadingLocation = false);
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final userLocation = LatLng(position.latitude, position.longitude);

      if (!mounted) return;

      setState(() {
        _currentCenter = userLocation;
        _markers = [
          Marker(
            point: userLocation,
            width: 50,
            height: 50,
            child: const Icon(
              Icons.my_location,
              size: 36,
              color: Colors.blue,
            ),
          ),
        ];
      });

      _mapController.move(userLocation, 16);

      final snapshot =
          await FirebaseFirestore.instance.collection('bins').get();

      final bins = snapshot.docs.map((doc) {
        final data = doc.data();

        final lat = _toDouble(data['latitude']);
        final lng = _toDouble(data['longitude']);

        final distance = Geolocator.distanceBetween(
          userLocation.latitude,
          userLocation.longitude,
          lat,
          lng,
        );

        return {
          ...data,
          'distance': distance,
        };
      }).toList();

      bins.sort(
        (a, b) => (a['distance'] as double).compareTo(
          b['distance'] as double,
        ),
      );

      final nearbyBins = bins.take(20).toList();

      final binMarkers = nearbyBins.map((bin) {
        final lat = _toDouble(bin['latitude']);
        final lng = _toDouble(bin['longitude']);

        return Marker(
          point: LatLng(lat, lng),
          width: 46,
          height: 46,
          child: GestureDetector(
            onTap: () {
              _showBinInfo(bin);
            },
            child: const Icon(
              Icons.location_on,
              color: ReLeafColors.primary,
              size: 40,
            ),
          ),
        );
      }).toList();

      if (!mounted) return;

      setState(() {
        _markers = [
          Marker(
            point: userLocation,
            width: 50,
            height: 50,
            child: const Icon(
              Icons.my_location,
              size: 36,
              color: Colors.blue,
            ),
          ),
          ...binMarkers,
        ];
        _isLoadingLocation = false;
      });
    } catch (e) {
      debugPrint('Location error: $e');

      if (!mounted) return;

      setState(() => _isLoadingLocation = false);
      _showError(l.locationFailedLoad);
    }
  }

  double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0.0;
  }

  void _showError(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showBinInfo(Map<String, dynamic> bin) {
  final l = AppLocalizations.of(context)!;
  final distanceKm = (_toDouble(bin['distance']) / 1000).toStringAsFixed(1);

  final lat = _toDouble(bin['latitude']);
  final lng = _toDouble(bin['longitude']);

  showModalBottomSheet(
    context: context,
    backgroundColor:
        isDarkMode ? const Color(0xFF1F2F2A) : ReLeafColors.background,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(22),
      ),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              bin['binName'] ?? l.locationDefaultBinName,
              textAlign: TextAlign.center,
              style: ReLeafTextStyles.title.copyWith(
                fontSize: 20,
                color: mainTextColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${bin['city'] ?? ''} ${bin['Region'] ?? ''}',
              textAlign: TextAlign.center,
              style: ReLeafTextStyles.body.copyWith(
                color: subTextColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l.locationBinDistance(
                bin['binType'] ?? 'Bin',
                distanceKm,
              ),
              style: ReLeafTextStyles.subtitle.copyWith(
                color: isDarkMode ? Colors.white70 : ReLeafColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 18),

            ReLeafButton(
              text: 'Open in Google Maps',
              icon: Icons.map_rounded,
              onPressed: () {
                Navigator.pop(context);
                _openGoogleMaps(lat, lng);
              },
            ),
          ],
        ),
      );
    },
  );
}

  void _openCategoryPage(String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BinsListPage(category: category),
      ),
    );
  }

  Widget _customCard({
    required Widget child,
    EdgeInsetsGeometry padding = const EdgeInsets.all(16),
    EdgeInsetsGeometry margin = EdgeInsets.zero,
    Color? color,
  }) {
    return Container(
      width: double.infinity,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? cardColor,
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

  Widget _infoBox(AppLocalizations l) {
    return _customCard(
      child: Row(
        children: [
          Icon(
            Icons.my_location,
            color: isDarkMode ? Colors.white70 : ReLeafColors.primary,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              _isLoadingLocation ? l.locationDetecting : l.locationNearestBins,
              style: ReLeafTextStyles.body.copyWith(
                color: subTextColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(
      String category, String label, AppLocalizations l) {
    final isTrash = category == 'Trash';

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: SizedBox(
          height: 120,
          child: InkWell(
            onTap: () => _openCategoryPage(category),
            borderRadius: BorderRadius.circular(20),
            child: _customCard(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 6,
              ),
              color: iconBoxColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    _getItemSvg(category),
                    width: 30,
                    height: 30,
                    colorFilter: ColorFilter.mode(
                      mainTextColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Flexible(
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: ReLeafTextStyles.title.copyWith(
                        fontSize: 14,
                        color: mainTextColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 3),
                  SizedBox(
                    height: 16,
                    child: isTrash
                        ? Text(
                            l.locationNonRecyclables,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: ReLeafTextStyles.subtitle.copyWith(
                              fontSize: 9,
                              color: subTextColor,
                            ),
                          )
                        : null,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onBottomTap(int index) {
    if (index == 2) return;

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
      final user = FirebaseAuth.instance.currentUser;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => Profile(
            name: 'User',
            email: user?.email ?? 'user@email.com',
          ),
        ),
      );
    }
  }

  String _getItemSvg(String itemName) {
    final item = itemName.toLowerCase();

    if (item.contains('plastic')) return 'assets/icons/plastic.svg';
    if (item.contains('glass')) return 'assets/icons/glass.svg';
    if (item.contains('paper')) return 'assets/icons/paper.svg';
    if (item.contains('metal')) return 'assets/icons/metal.svg';
    if (item.contains('cardboard')) return 'assets/icons/cardboard.svg';
    if (item.contains('trash')) return 'assets/icons/trash.svg';

    return 'assets/icons/recycling.svg';
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              AppTopBar(
                title: l.locationPageTitle,
                subtitle: l.locationPageSubtitle,
                icon: Icons.location_on_rounded,
                showBackButton: false,
                showNotifications: false,
                gradientColors: topBarGradient,
              ),
              const SizedBox(height: 6),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 18, 16, 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _customCard(
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.zero,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: SizedBox(
                            height: 300,
                            child: Stack(
                              children: [
                                FlutterMap(
                                  mapController: _mapController,
                                  options: MapOptions(
                                    initialCenter: _currentCenter,
                                    initialZoom: 14,
                                  ),
                                  children: [
                                    TileLayer(
                                      urlTemplate:
                                          'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                                      subdomains: const ['a', 'b', 'c'],
                                      userAgentPackageName:
                                          'com.example.releaf_app',
                                      tileProvider: NetworkTileProvider(),
                                    ),
                                    MarkerLayer(markers: _markers),
                                  ],
                                ),
                                if (_isLoadingLocation)
                                  Positioned(
                                    top: 12,
                                    right: 12,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isDarkMode
                                            ? const Color(0xFF1F2F2A)
                                                .withOpacity(0.95)
                                            : Colors.white.withOpacity(0.95),
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: shadowColor,
                                            blurRadius: 8,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const SizedBox(
                                            width: 16,
                                            height: 16,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: ReLeafColors.secondary,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            l.locationLoadingBins,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: mainTextColor,
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
                      ),
                      const SizedBox(height: 12),
                      _infoBox(l),
                      const SizedBox(height: 24),
                      Text(
                        l.locationBinsCategory,
                        style: ReLeafTextStyles.title.copyWith(
                          fontSize: 24,
                          color: mainTextColor,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          _buildCategoryButton(
                              'Cardboard', l.locationCategoryCardboard, l),
                          _buildCategoryButton(
                              'Glass', l.locationCategoryGlass, l),
                          _buildCategoryButton(
                              'Metal', l.locationCategoryMetal, l),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          _buildCategoryButton(
                              'Paper', l.locationCategoryPaper, l),
                          _buildCategoryButton(
                              'Plastic', l.locationCategoryPlastic, l),
                          _buildCategoryButton(
                              'Trash', l.locationCategoryTrash, l),
                        ],
                      ),
                      const SizedBox(height: 24),
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
}
