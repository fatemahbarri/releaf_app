import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';

import '../../../services/firebase_service.dart';
import '../../theme/admin_theme.dart';
import '../../widgets/AdminBar.dart';

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

  static const Color primary = Color(0xFF7FB77E);
  static const Color secondary = Color(0xFF5E9C76);
  static const Color background = Color(0xFFF7FBF2);
  static const Color lightGreen = Color(0xFFEAF6E3);
  static const Color border = Color(0xFFDCE8D7);
  static const Color textDark = Color(0xFF2F5D50);
  static const Color textMedium = Color(0xFF4E6A57);

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

  Widget _topBar() {
    return Container(
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
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
          ),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.add_location_alt_outlined,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              _isEditMode ? 'Edit Bin' : 'Add Bin',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    Widget? suffixIcon,
    bool readOnly = false,
    int maxLines = 1,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
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
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        maxLines: maxLines,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textDark,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            fontSize: 16,
            color: Color(0xFF8A9A8C),
          ),
          prefixIcon: Icon(
            icon,
            color: textMedium,
            size: 24,
          ),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  Widget _saveButton() {
    return GestureDetector(
      onTap: _isSaving ? null : _saveBin,
      child: Opacity(
        opacity: _isSaving ? 0.6 : 1,
        child: Container(
          width: double.infinity,
          height: 56,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [primary, secondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: primary.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
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
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
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
        _topBar(),

        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInputField(
                  controller: _binNameController,
                  hint: 'Bin Name',
                  icon: Icons.delete_outline,
                ),

                _buildInputField(
                  controller: _cityController,
                  hint: 'City',
                  icon: Icons.location_city_outlined,
                ),

                _buildInputField(
                  controller: _regionController,
                  hint: 'Region',
                  icon: Icons.map_outlined,
                ),

                _buildInputField(
                  controller: _categoryController,
                  hint: 'Bin Type',
                  icon: Icons.recycling_rounded,
                  readOnly: true,
                ),

                _buildInputField(
                  controller: _descriptionController,
                  hint: 'Description / Address',
                  icon: Icons.description_outlined,
                  maxLines: 2,
                  suffixIcon: IconButton(
                    onPressed: _isSearchingAddress ? null : _searchAddress,
                    icon: _isSearchingAddress
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: secondary,
                            ),
                          )
                        : const Icon(
                            Icons.location_on_outlined,
                            color: textMedium,
                          ),
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  'Select Location',
                  style: TextStyle(
                    color: textDark,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                Container(
                  height: 230,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: border),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
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
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: _selectedLocation,
                              width: 50,
                              height: 50,
                              child: const Icon(
                                Icons.location_on,
                                size: 40,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                _saveButton(),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ],
    ),
  ),


  bottomNavigationBar: Container(
    color: background,
    child: const AdminBar(selectedIndex: 2),
  ),
);;
  }
}