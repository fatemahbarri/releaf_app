import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../widgets/AdminBar.dart';
import '../../widgets/admin_background.dart';
import '../../widgets/admin_header.dart';
import '../../theme/admin_theme.dart';
import 'BinsByCategoryPage.dart';

class AdminBinsPage extends StatefulWidget {
  const AdminBinsPage({super.key});

  @override
  State<AdminBinsPage> createState() => _AdminBinsPageState();
}

class _AdminBinsPageState extends State<AdminBinsPage> {
  final TextEditingController _searchController = TextEditingController();
  final MapController _mapController = MapController();

  LatLng _currentCenter = const LatLng(26.385046, 50.189002);
  bool _isSearching = false;
  List<Marker> _markers = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getCurrentLocation();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
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
              color: AdminTheme.error,
              size: 40,
            ),
          ),
        ];
      });

      _mapController.move(searchedLocation, 16);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location search failed: $e')),
      );
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
        builder: (_) => BinsByCategoryPage(category: category),
      ),
    );
  }

  Widget _buildCategoryButton(String title) {
    final bool isTrash = title == 'Trash';

    return Expanded(
      child: InkWell(
        onTap: () => _openCategoryPage(title),
        borderRadius: BorderRadius.circular(27),
        child: Container(
          height: 105,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: AdminTheme.primary,
            borderRadius: BorderRadius.circular(27),
            boxShadow: const [
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: isTrash
                  ? const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Trash',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '(non-recyclables)',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AdminBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 24, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: AdminHeader(
                  title: 'Bins Management',
                  showBack: false,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 1,
                color: AdminTheme.border,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AdminTheme.card,
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(color: AdminTheme.border),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 16),
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                onSubmitted: (_) => _searchLocation(),
                                decoration: const InputDecoration(
                                  hintText: 'Search Location',
                                  hintStyle: TextStyle(
                                    color: Color(0xFF8A8A8A),
                                    fontSize: 16,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: _isSearching ? null : _searchLocation,
                              icon: _isSearching
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Icon(Icons.search),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AdminTheme.card,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AdminTheme.border),
                      ),
                      child: IconButton(
                        onPressed: _getCurrentLocation,
                        icon: const Icon(Icons.my_location),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: Container(
                    height: 250,
                    color: const Color(0xFFEAEAEA),
                    child: FlutterMap(
                      mapController: _mapController,
                      options: MapOptions(
                        initialCenter: _currentCenter,
                        initialZoom: 15,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
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
              const SizedBox(height: 48),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 28),
                child: Text(
                  'Bins Category',
                  style: TextStyle(
                    color: AdminTheme.textMuted,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    _buildCategoryButton('Cardboard'),
                    _buildCategoryButton('Glass'),
                    _buildCategoryButton('Metal'),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    _buildCategoryButton('Paper'),
                    _buildCategoryButton('Plastic'),
                    _buildCategoryButton('Trash'),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AdminBar(selectedIndex: 2),
    );
  }
}
