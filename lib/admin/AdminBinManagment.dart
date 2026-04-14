import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'AdminBinManagment2.dart';

class AdminBinManagment extends StatefulWidget {
  const AdminBinManagment({super.key});

  @override
  State<AdminBinManagment> createState() => _AdminBinManagmentState();
}

class _AdminBinManagmentState extends State<AdminBinManagment> {
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

    setState(() {
      _isSearching = true;
    });

    try {
      final results = await locationFromAddress(query);
      if (results.isEmpty) return;

      final place = results.first;
      final searchedLocation = LatLng(place.latitude, place.longitude);

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
    } finally {
      setState(() {
        _isSearching = false;
      });
    }
  }

  void _openCategoryPage(String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AdminBinManagment2(category: category),
      ),
    );
  }

  Widget _buildCategoryButton(String title) {
    final isTrash = title == 'Trash';

    return Expanded(
      child: InkWell(
        onTap: () => _openCategoryPage(title),
        borderRadius: BorderRadius.circular(27),
        child: Container(
          height: 105,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF4E9F67),
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3FFE2),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 24, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              if (Navigator.canPop(context)) {
                                Navigator.pop(context);
                              }
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              size: 30,
                              color: Color(0xFF6F8F74),
                            ),
                          ),
                          const Expanded(
                            child: Text(
                              'Bins Management',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF7CA385),
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 48),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 1,
                      color: const Color(0xFFBDBDBD),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(40),
                                border: Border.all(
                                  color: const Color(0xFFD9D9D9),
                                ),
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
                                          color: Color(0xFFB3B3B3),
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
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
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
                          color: Color(0xFF675F5A),
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