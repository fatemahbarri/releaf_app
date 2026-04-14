import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';

class AddBin extends StatefulWidget {
  final String category;
  final Map<String, String>? initialData;

  const AddBin({
    super.key,
    required this.category,
    this.initialData,
  });

  @override
  State<AddBin> createState() => _AddBinState();
}

class _AddBinState extends State<AddBin> {
  late final TextEditingController _binNameController;
  late final TextEditingController _cityController;
  late final TextEditingController _areaController;
  late final TextEditingController _addressController;

  final MapController _mapController = MapController();

  LatLng _selectedLocation = const LatLng(26.385046, 50.189002);
  bool _isSearchingAddress = false;

  bool get _isEditMode => widget.initialData != null;

  @override
  void initState() {
    super.initState();

    _binNameController = TextEditingController(
      text: widget.initialData?['name'] ?? '',
    );
    _cityController = TextEditingController(
      text: widget.initialData?['city'] ?? '',
    );
    _areaController = TextEditingController(
      text: widget.initialData?['area'] ?? '',
    );
    _addressController = TextEditingController(
      text: widget.initialData?['address'] ?? '',
    );

    final lat = double.tryParse(widget.initialData?['latitude'] ?? '');
    final lng = double.tryParse(widget.initialData?['longitude'] ?? '');

    if (lat != null && lng != null) {
      _selectedLocation = LatLng(lat, lng);
    }
  }

  Future<void> _searchAddress() async {
    final query = _addressController.text.trim();
    if (query.isEmpty) return;

    setState(() {
      _isSearchingAddress = true;
    });

    try {
      final results = await locationFromAddress(query);
      if (results.isEmpty) return;

      final place = results.first;
      final newLocation = LatLng(place.latitude, place.longitude);

      setState(() {
        _selectedLocation = newLocation;
      });

      _mapController.move(newLocation, 16);
    } finally {
      setState(() {
        _isSearchingAddress = false;
      });
    }
  }

  void _saveBin() {
    final binName = _binNameController.text.trim();
    final city = _cityController.text.trim();
    final area = _areaController.text.trim();
    final address = _addressController.text.trim();

    if (binName.isEmpty || city.isEmpty || area.isEmpty || address.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    Navigator.pop(context, {
      'category': widget.category,
      'name': binName,
      'city': city,
      'area': area,
      'address': address,
      'latitude': _selectedLocation.latitude.toString(),
      'longitude': _selectedLocation.longitude.toString(),
    });
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    Widget? suffixIcon,
    VoidCallback? onTap,
    bool readOnly = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        border: Border.all(color: const Color(0xFFC4C4C4)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        onTap: onTap,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF969696),
          ),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
          suffixIcon: suffixIcon,
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
  void dispose() {
    _binNameController.dispose();
    _cityController.dispose();
    _areaController.dispose();
    _addressController.dispose();
    super.dispose();
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
                              _isEditMode ? 'Edit Bin' : 'Add Bin',
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
                    const SizedBox(height: 50),
                    _buildInputField(
                      controller: _binNameController,
                      hint: 'Bin Name',
                    ),
                    _buildInputField(
                      controller: _cityController,
                      hint: 'City',
                    ),
                    _buildInputField(
                      controller: _areaController,
                      hint: 'Area',
                    ),
                    _buildInputField(
                      controller: TextEditingController(text: widget.category),
                      hint: 'Bin type',
                      readOnly: true,
                    ),
                    _buildInputField(
                      controller: _addressController,
                      hint: 'Select Address',
                      suffixIcon: IconButton(
                        onPressed: _isSearchingAddress ? null : _searchAddress,
                        icon: _isSearchingAddress
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Icon(
                                Icons.location_on_outlined,
                                color: Color(0xFFBDBDBD),
                                size: 30,
                              ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(28),
                        child: SizedBox(
                          width: 320,
                          height: 200,
                          child: FlutterMap(
                            mapController: _mapController,
                            options: MapOptions(
                              initialCenter: _selectedLocation,
                              initialZoom: 15,
                              onTap: (tapPosition, point) {
                                setState(() {
                                  _selectedLocation = point;
                                  _addressController.text =
                                      '${point.latitude.toStringAsFixed(6)}, ${point.longitude.toStringAsFixed(6)}';
                                });
                              },
                            ),
                            children: [
                              TileLayer(
                                urlTemplate:
                                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                userAgentPackageName: 'com.example.releaf_app',
                                tileProvider: NetworkTileProvider(),
                              ),
                              MarkerLayer(
                                markers: [
                                  Marker(
                                    point: _selectedLocation,
                                    width: 50,
                                    height: 50,
                                    child: const Icon(
                                      Icons.location_on,
                                      color: Colors.redAccent,
                                      size: 40,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 34),
                    Center(
                      child: SizedBox(
                        width: 220,
                        height: 62,
                        child: ElevatedButton(
                          onPressed: _saveBin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFB8D67D),
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            _isEditMode ? 'Save Changes' : 'Save',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF5B5554),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
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