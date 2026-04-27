import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../widgets/AdminBar.dart';
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

  static const Color primary = Color(0xFF7FB77E);
  static const Color secondary = Color(0xFF5E9C76);
  static const Color background = Color(0xFFF7FBF2);
  static const Color lightGreen = Color(0xFFEAF6E3);
  static const Color border = Color(0xFFDCE8D7);
  static const Color textDark = Color(0xFF2F5D50);
  static const Color textMedium = Color(0xFF4E6A57);

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
              color: AdminTheme.error,
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
        builder: (_) => BinsByCategoryPage(category: category),
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
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              decoration: BoxDecoration(
                color: lightGreen,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: border),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: textDark, size: 28),
                  const SizedBox(height: 6),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: textDark,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    height: 14,
                    child: isTrash
                        ? const Text(
                            'non-recyclables',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: textMedium,
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

  Widget _buildRoundIconButton({
    required IconData icon,
    required VoidCallback? onPressed,
    Widget? child,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Opacity(
        opacity: onPressed == null ? 0.55 : 1,
        child: Container(
          width: 44,
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [primary, secondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: primary.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: child ?? Icon(icon, color: Colors.white, size: 18),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [primary, secondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(24),
                ),
              ),
              child: Row(
                children: [
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
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bins Management',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Manage recycling bin locations',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
                          child: TextField(
                            controller: _searchController,
                            onSubmitted: (_) => _searchLocation(),
                            decoration: InputDecoration(
                              hintText: 'Search Location',
                              hintStyle: const TextStyle(
                                color: Color(0xFF8A9A8C),
                              ),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: textMedium,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(22),
                                borderSide: const BorderSide(color: border),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(22),
                                borderSide: const BorderSide(color: border),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(22),
                                borderSide: const BorderSide(
                                  color: primary,
                                  width: 1.4,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        _buildRoundIconButton(
                          icon: Icons.search,
                          onPressed: _isSearching ? null : _searchLocation,
                          child: _isSearching
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : null,
                        ),
                        const SizedBox(width: 8),
                        _buildRoundIconButton(
                          icon: Icons.my_location,
                          onPressed: _getCurrentLocation,
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: border),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
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
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      'Bins Category',
                      style: TextStyle(
                        color: textDark,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 14),

                    Row(
                      children: [
                        _buildCategoryButton(
                          'Cardboard',
                          Icons.inventory_2_outlined,
                        ),
                        _buildCategoryButton(
                          'Glass',
                          Icons.wine_bar_outlined,
                        ),
                        _buildCategoryButton(
                          'Metal',
                          Icons.settings_outlined,
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        _buildCategoryButton(
                          'Paper',
                          Icons.description_outlined,
                        ),
                        _buildCategoryButton(
                          'Plastic',
                          Icons.local_drink_outlined,
                        ),
                        _buildCategoryButton(
                          'Trash',
                          Icons.delete_outline,
                        ),
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

      // ✅ Navigation works because we use your real AdminBar
      bottomNavigationBar: const AdminBar(selectedIndex: 2),
    );
  }
}