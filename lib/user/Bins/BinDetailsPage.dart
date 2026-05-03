import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

import 'package:releaf_app/services/route_service.dart';
import 'package:releaf_app/widgets/app_background.dart';
import 'package:releaf_app/user/UserWidgets/UserBottomNav.dart';
import 'package:releaf_app/widgets/app_top_bar.dart';
import 'package:releaf_app/widgets/releaf_ui.dart';

class BinDetailsPage extends StatefulWidget {
  final String locationName;
  final String address;
  final String category;
  final double latitude;
  final double longitude;

  const BinDetailsPage({
    super.key,
    required this.locationName,
    required this.address,
    required this.category,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<BinDetailsPage> createState() => _BinDetailsPageState();
}

class _BinDetailsPageState extends State<BinDetailsPage> {
  final MapController _mapController = MapController();

  LatLng? _userLocation;
  double? _distanceKm;
  bool _isLoadingLocation = true;
  List<LatLng> _routePoints = [];

  /// ✅ DARK MODE COLORS
  bool get isDarkMode => Theme.of(context).brightness == Brightness.dark;

  Color get cardColor =>
      isDarkMode ? const Color(0xFF1F2F2A) : Colors.white.withOpacity(0.96);

  Color get borderColor => isDarkMode
      ? Colors.white.withOpacity(0.08)
      : Colors.white.withOpacity(0.8);

  Color get shadowColor => isDarkMode
      ? Colors.black.withOpacity(0.25)
      : Colors.black.withOpacity(0.06);

  Color get mainTextColor => isDarkMode ? Colors.white : ReLeafColors.textDark;

  Color get subTextColor =>
      isDarkMode ? Colors.white70 : ReLeafColors.textDark.withOpacity(0.65);

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
      _loadUserLocation();
    });
  }

  Future<void> _loadUserLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition();
      final userLocation = LatLng(position.latitude, position.longitude);
      final binLocation = LatLng(widget.latitude, widget.longitude);

      final distance = Geolocator.distanceBetween(
        userLocation.latitude,
        userLocation.longitude,
        binLocation.latitude,
        binLocation.longitude,
      );

      List<LatLng> route;

      try {
        route = await RouteService.getRoute(
          start: userLocation,
          end: binLocation,
        );
      } catch (_) {
        route = [userLocation, binLocation];
      }

      if (!mounted) return;

      setState(() {
        _userLocation = userLocation;
        _distanceKm = distance / 1000;
        _routePoints = route;
        _isLoadingLocation = false;
      });

      _mapController.fitCamera(
        CameraFit.bounds(
          bounds: LatLngBounds.fromPoints([userLocation, binLocation]),
          padding: const EdgeInsets.all(60),
        ),
      );
    } catch (_) {
      if (!mounted) return;
      setState(() => _isLoadingLocation = false);
    }
  }

  /// ✅ CUSTOM CARD
  Widget _customCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
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

  @override
  Widget build(BuildContext context) {
    final binLocation = LatLng(widget.latitude, widget.longitude);

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              /// ✅ TOP BAR
              AppTopBar(
                title: widget.locationName,
                subtitle: widget.address,
                titleSize: 14,
                subtitleSize: 11,
                icon: Icons.location_on_rounded,
                showBackButton: true,
                gradientColors: topBarGradient,
              ),

              /// ✅ INFO CARDS
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: Column(
                  children: [
                    _customCard(
                      child: Row(
                        children: [
                          Icon(
                            Icons.recycling_rounded,
                            color: isDarkMode
                                ? Colors.white70
                                : ReLeafColors.primary,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Category: ${widget.category}',
                              style: TextStyle(
                                color: mainTextColor,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    _customCard(
                      child: Row(
                        children: [
                          Icon(
                            Icons.route_rounded,
                            color: isDarkMode
                                ? Colors.white70
                                : ReLeafColors.primary,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              _isLoadingLocation
                                  ? 'Calculating route...'
                                  : _distanceKm == null
                                      ? 'Location unavailable'
                                      : 'Distance: ${_distanceKm!.toStringAsFixed(2)} km',
                              style: TextStyle(
                                color: subTextColor,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              /// ✅ MAP CARD
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: borderColor),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: FlutterMap(
                        mapController: _mapController,
                        options: MapOptions(
                          initialCenter: binLocation,
                          initialZoom: 16,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                            subdomains: const ['a', 'b', 'c'],
                          ),
                          if (_routePoints.isNotEmpty)
                            PolylineLayer(
                              polylines: [
                                Polyline(
                                  points: _routePoints,
                                  strokeWidth: 4,
                                  color: ReLeafColors.primary,
                                ),
                              ],
                            ),
                          MarkerLayer(
                            markers: [
                              if (_userLocation != null)
                                Marker(
                                  point: _userLocation!,
                                  child: const Icon(
                                    Icons.my_location,
                                    color: Colors.blue,
                                    size: 36,
                                  ),
                                ),
                              Marker(
                                point: binLocation,
                                child: const Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                  size: 46,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
