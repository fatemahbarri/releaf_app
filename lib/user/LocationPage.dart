import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'LocationPage2.dart';
import '../widgets/releaf_ui.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final TextEditingController _searchController = TextEditingController();
  final MapController _mapController = MapController();

  LatLng _currentCenter = const LatLng(26.385046, 50.189002);
  bool _isSearching = false;
  List<Marker> _markers = [];

  Future<void> _getCurrentLocation() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return;

      var permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return;
      }

      if (permission == LocationPermission.deniedForever) return;

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
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
    } catch (e) {
      debugPrint('Location error: $e');
    }
  }

  Future<void> _searchLocation() async {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;

    setState(() => _isSearching = true);

    try {
      final results = await locationFromAddress(query);
      if (results.isEmpty) return;

      final place = results.first;
      final searchedLocation = LatLng(place.latitude, place.longitude);

      if (!mounted) return;

      setState(() {
        _currentCenter = searchedLocation;
        _markers = [
          Marker(
            point: searchedLocation,
            width: 50,
            height: 50,
            child: const Icon(
              Icons.location_on,
              color: Colors.red,
              size: 40,
            ),
          ),
        ];
      });

      _mapController.move(searchedLocation, 16);
    } catch (e) {
      debugPrint('Search location error: $e');
    } finally {
      if (mounted) {
        setState(() => _isSearching = false);
      }
    }
  }

  void _openCategoryPage(String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LocationPage2(category: category),
      ),
    );
  }

Widget _buildCategoryButton(String title, IconData icon) {
  final isTrash = title == 'Trash';

  return Expanded(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: SizedBox(
        height: 110, 
        child: InkWell(
          onTap: () => _openCategoryPage(title),
          borderRadius: BorderRadius.circular(20),
          child: ReLeafCard(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            margin: EdgeInsets.zero,
            color: ReLeafColors.lightGreen,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: ReLeafColors.textDark, size: 28),

                const SizedBox(height: 6),

                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: ReLeafTextStyles.title.copyWith(fontSize: 15),
                ),

                
                const SizedBox(height: 4),

                SizedBox(
                  height: 14, 
                  child: isTrash
                      ? Text(
                          'non-recyclables',
                          textAlign: TextAlign.center,
                          style: ReLeafTextStyles.subtitle.copyWith(
                            fontSize: 10,
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
                color: selected ? ReLeafColors.primary.withOpacity(0.25) : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                icon,
                color: selected ? ReLeafColors.textDark : ReLeafColors.textMedium,
                size: 27,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: selected ? ReLeafColors.textDark : ReLeafColors.textMedium,
                fontWeight: selected ? FontWeight.bold : FontWeight.w500,
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
    return Scaffold(
      backgroundColor: ReLeafColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const ReLeafHeader(
              title: 'Bin Location',
              subtitle: 'Find nearby recycling bins',
              icon: Icons.location_on_rounded,
              showBackButton: true,
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ReLeafSearchBar(
                            controller: _searchController,
                            hintText: 'Search Location',
                            onChanged: (_) {},
                          ),
                        ),
                        const SizedBox(width: 10),
                        ReLeafButton(
                          text: '',
                          icon: _isSearching ? null : Icons.search,
                          small: true,
                          onPressed: _isSearching ? null : _searchLocation,
                        ),
                        const SizedBox(width: 8),
                        ReLeafButton(
                          text: '',
                          icon: Icons.my_location,
                          small: true,
                          onPressed: _getCurrentLocation,
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    ReLeafCard(
                      padding: EdgeInsets.zero,
                      margin: EdgeInsets.zero,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: SizedBox(
                          height: 250,
                          child: FlutterMap(
                            mapController: _mapController,
                            options: MapOptions(
                              initialCenter: _currentCenter,
                              initialZoom: 15,
                            ),
                            children: [
                              TileLayer(
                                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                                subdomains: const ['a', 'b', 'c'],
                                userAgentPackageName: 'com.example.releaf_app',
                                tileProvider: NetworkTileProvider(),
                              ),
                              MarkerLayer(markers: _markers),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    Text(
                      'Bins Category',
                      style: ReLeafTextStyles.title.copyWith(fontSize: 24),
                    ),

                    const SizedBox(height: 14),

                    Row(
                      children: [
                        _buildCategoryButton('Cardboard', Icons.inventory_2_outlined),
                        _buildCategoryButton('Glass', Icons.wine_bar_outlined),
                        _buildCategoryButton('Metal', Icons.settings_outlined),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        _buildCategoryButton('Paper', Icons.description_outlined),
                        _buildCategoryButton('Plastic', Icons.local_drink_outlined),
                        _buildCategoryButton('Trash', Icons.delete_outline),
                      ],
                    ),
                  ],
                ),
              ),
            ),

          ReLeafBottomBar(
  selectedIndex: 2,
  onTap: (index) {
    // navigation later
  },
)
          ],
        ),
      ),
    );
  }
}