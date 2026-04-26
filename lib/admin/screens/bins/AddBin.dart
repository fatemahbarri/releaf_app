import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';

import '../../../services/firebase_service.dart';
import '../../theme/admin_theme.dart';
import '../../widgets/AdminBar.dart';
import '../../widgets/admin_background.dart';
import '../../widgets/admin_header.dart';

class AddBin extends StatefulWidget {
  final String category;
  final Map<String, dynamic>? initialData;

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
  late final TextEditingController _regionController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _categoryController;

  final MapController _mapController = MapController();
  final FirebaseService _firebaseService = FirebaseService();

  LatLng _selectedLocation = const LatLng(26.385046, 50.189002);
  bool _isSearchingAddress = false;
  bool _isSaving = false;

  bool get _isEditMode => widget.initialData != null;

  @override
  void initState() {
    super.initState();

    _binNameController = TextEditingController(
      text: widget.initialData?['binName']?.toString() ?? '',
    );
    _cityController = TextEditingController(
      text: widget.initialData?['city']?.toString() ?? '',
    );
    _regionController = TextEditingController(
      text: widget.initialData?['Region']?.toString() ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.initialData?['Description']?.toString() ?? '',
    );
    _categoryController = TextEditingController(text: widget.category);

    final lat = widget.initialData?['latitude'];
    final lng = widget.initialData?['longitude'];

    if (lat != null && lng != null) {
      _selectedLocation = LatLng(
        double.tryParse(lat.toString()) ?? 26.385046,
        double.tryParse(lng.toString()) ?? 50.189002,
      );
    }
  }

  Future<void> _searchAddress() async {
    final query = _descriptionController.text.trim();
    if (query.isEmpty) return;

    setState(() => _isSearchingAddress = true);

    try {
      final results = await locationFromAddress(query);

      if (results.isEmpty) return;

      final place = results.first;
      final newLocation = LatLng(place.latitude, place.longitude);

      setState(() => _selectedLocation = newLocation);
      _mapController.move(newLocation, 16);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location search failed: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => _isSearchingAddress = false);
      }
    }
  }

  Future<void> _saveBin() async {
    final binName = _binNameController.text.trim();
    final city = _cityController.text.trim();
    final region = _regionController.text.trim();
    final description = _descriptionController.text.trim();

    if (binName.isEmpty ||
        city.isEmpty ||
        region.isEmpty ||
        description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      if (_isEditMode) {
        await _firebaseService.updateBin(
          id: widget.initialData!['id'].toString(),
          binName: binName,
          binType: widget.category,
          description: description,
          region: region,
          city: city,
          latitude: _selectedLocation.latitude,
          longitude: _selectedLocation.longitude,
          isActive: widget.initialData?['isActive']?.toString() ?? 'Active',
        );
      } else {
        await _firebaseService.addBin(
          binName: binName,
          binType: widget.category,
          description: description,
          region: region,
          city: city,
          latitude: _selectedLocation.latitude,
          longitude: _selectedLocation.longitude,
        );
      }

      if (!mounted) return;
      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  void dispose() {
    _binNameController.dispose();
    _cityController.dispose();
    _regionController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    Widget? suffixIcon,
    bool readOnly = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: AdminTheme.card,
        border: Border.all(color: AdminTheme.border),
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
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AdminTheme.textDark,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF969696),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 18,
          ),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AdminBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 22, 24, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AdminHeader(
                title: _isEditMode ? 'Edit Bin' : 'Add Bin',
                showBack: true,
              ),
              const SizedBox(height: 40),
              _buildInputField(
                controller: _binNameController,
                hint: 'Bin Name',
              ),
              _buildInputField(
                controller: _cityController,
                hint: 'City',
              ),
              _buildInputField(
                controller: _regionController,
                hint: 'Region',
              ),
              _buildInputField(
                controller: _categoryController,
                hint: 'Bin Type',
                readOnly: true,
              ),
              _buildInputField(
                controller: _descriptionController,
                hint: 'Description',
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
                          color: AdminTheme.textMuted,
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
                          setState(() => _selectedLocation = point);
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
                                color: AdminTheme.error,
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
                    onPressed: _isSaving ? null : _saveBin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AdminTheme.primary,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: _isSaving
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            _isEditMode ? 'Save Changes' : 'Save',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
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
      bottomNavigationBar: const AdminBar(selectedIndex: 2),
    );
  }
}
