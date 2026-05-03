import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';

import '../../../services/firebase_service.dart';
import 'locations_data.dart';
import '../../widgets/AdminBar.dart';
import '../../widgets/admin_background.dart';

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
  late final TextEditingController _descriptionController;

  String? _selectedCategory;
  String? _selectedCity;
  String? _selectedDistrict;

  bool _isActive = true;

  final List<String> _categories = [
    'Plastic',
    'Paper',
    'Metal',
    'Glass',
    'Cardboard',
    'Trash',
  ];

  final MapController _mapController = MapController();
  final FirebaseService _firebaseService = FirebaseService();

  LatLng _selectedLocation = const LatLng(26.385046, 50.189002);
  bool _isSearchingAddress = false;
  bool _isSaving = false;

  static const Color primary = Color(0xFF7FB77E);
  static const Color secondary = Color(0xFF5E9C76);
  static const Color border = Color(0xFFDCE8D7);
  static const Color textDark = Color(0xFF2F5D50);
  static const Color textMedium = Color(0xFF4E6A57);

  bool get _isEditMode => widget.initialData != null;
  bool get isDark => Theme.of(context).brightness == Brightness.dark;

  Color get cardBg => isDark ? const Color(0xFF1F2D28) : Colors.white;
  Color get borderColor => isDark ? Colors.white10 : border;
  Color get titleColor => isDark ? Colors.white : textDark;
  Color get subTextColor => isDark ? Colors.white70 : textMedium;
  Color get hintColor => isDark ? Colors.white54 : textMedium;
  Color get dropdownColor => isDark ? const Color(0xFF1F2D28) : Colors.white;
  Color get topBarStart => isDark ? const Color(0xFF1F2D28) : primary;
  Color get topBarEnd => isDark ? const Color(0xFF31443B) : secondary;

  @override
  void initState() {
    super.initState();

    _binNameController = TextEditingController(
      text: widget.initialData?['binName']?.toString() ??
          widget.initialData?['name']?.toString() ??
          '',
    );

    _descriptionController = TextEditingController(
      text: widget.initialData?['Description']?.toString() ??
          widget.initialData?['description']?.toString() ??
          widget.initialData?['address']?.toString() ??
          '',
    );

    _selectedCity = widget.initialData?['city']?.toString();

    if (_selectedCity != null && !cityDistricts.containsKey(_selectedCity)) {
      _selectedCity = null;
    }

    _selectedDistrict = widget.initialData?['region']?.toString() ??
        widget.initialData?['Region']?.toString() ??
        widget.initialData?['province']?.toString();

    if (_selectedCity != null &&
        _selectedDistrict != null &&
        !cityDistricts[_selectedCity]!.contains(_selectedDistrict)) {
      _selectedDistrict = null;
    }

    _selectedCategory = widget.initialData?['binType']?.toString() ??
        widget.initialData?['type']?.toString() ??
        widget.initialData?['category']?.toString() ??
        widget.category;

    if (_selectedCategory != null && !_categories.contains(_selectedCategory)) {
      _selectedCategory = widget.category;
    }

    final activeValue = widget.initialData?['isActive'];

    if (activeValue is bool) {
      _isActive = activeValue;
    } else if (activeValue is String) {
      _isActive = activeValue.toLowerCase() == 'active' ||
          activeValue.toLowerCase() == 'true';
    } else {
      _isActive = true;
    }

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
      if (mounted) setState(() => _isSearchingAddress = false);
    }
  }

  Future<void> _saveBin() async {
    final binName = _binNameController.text.trim();
    final city = _selectedCity ?? '';
    final region = _selectedDistrict ?? '';
    final binType = _selectedCategory ?? '';
    final description = _descriptionController.text.trim();

    if (binName.isEmpty ||
        city.isEmpty ||
        region.isEmpty ||
        binType.isEmpty ||
        description.isEmpty ||
        region == 'Select district') {
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
          binType: binType,
          description: description,
          region: region,
          city: city,
          latitude: _selectedLocation.latitude,
          longitude: _selectedLocation.longitude,
          isActive: _isActive,
        );
      } else {
        await _firebaseService.addBin(
          binName: binName,
          binType: binType,
          description: description,
          region: region,
          city: city,
          latitude: _selectedLocation.latitude,
          longitude: _selectedLocation.longitude,
          isActive: _isActive,
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
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  void dispose() {
    _binNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Widget _categoryIcon(String type, {Color? color}) {
    final iconColor = color ?? subTextColor;
    Widget icon;

    switch (type.toLowerCase()) {
      case 'plastic':
        icon = Image.asset('assets/images/plastic-bottle.png', width: 24);
        break;
      case 'metal':
        icon = Image.asset('assets/images/can.png', width: 24);
        break;
      case 'paper':
        icon = Image.asset('assets/images/paper.png', width: 24);
        break;
      case 'glass':
        icon = Image.asset('assets/images/glass.png', width: 24);
        break;
      case 'cardboard':
        icon = Image.asset('assets/images/cardboard.png', width: 24);
        break;
      case 'trash':
        icon = Image.asset('assets/images/trash.png', width: 24);
        break;
      default:
        return Icon(Icons.recycling, color: iconColor);
    }

    return ColorFiltered(
      colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
      child: icon,
    );
  }

  Widget _topBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [topBarStart, topBarEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
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
    int maxLines = 1,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.22 : 0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: titleColor,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 16,
            color: hintColor,
            fontWeight: FontWeight.w600,
          ),
          prefixIcon: Icon(icon, color: subTextColor, size: 24),
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

  Widget _dropdownContainer({required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.22 : 0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _cityDropdown() {
    return _dropdownContainer(
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedCity,
          isExpanded: true,
          dropdownColor: dropdownColor,
          icon: Icon(Icons.keyboard_arrow_down, color: subTextColor),
          hint: Row(
            children: [
              Icon(Icons.location_city_outlined, color: subTextColor),
              const SizedBox(width: 12),
              Text(
                'Governorate',
                style: TextStyle(
                  color: hintColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          selectedItemBuilder: (context) {
            return cityDistricts.keys.map((city) {
              return Row(
                children: [
                  Icon(Icons.location_city_outlined, color: subTextColor),
                  const SizedBox(width: 12),
                  Text(
                    city,
                    style: TextStyle(
                      color: titleColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              );
            }).toList();
          },
          items: cityDistricts.keys.map((city) {
            return DropdownMenuItem<String>(
              value: city,
              child: Text(
                city,
                style: TextStyle(
                  color: titleColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedCity = value;
              _selectedDistrict = null;
            });
          },
        ),
      ),
    );
  }

  Widget _districtDropdown() {
    final districts =
        _selectedCity == null ? <String>[] : cityDistricts[_selectedCity]!;

    return _dropdownContainer(
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedDistrict,
          isExpanded: true,
          dropdownColor: dropdownColor,
          icon: Icon(Icons.keyboard_arrow_down, color: subTextColor),
          hint: Row(
            children: [
              Icon(Icons.map_outlined, color: subTextColor),
              const SizedBox(width: 12),
              Text(
                'District',
                style: TextStyle(
                  color: hintColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          selectedItemBuilder: (context) {
            return districts.map((district) {
              return Row(
                children: [
                  Icon(Icons.map_outlined, color: subTextColor),
                  const SizedBox(width: 12),
                  Text(
                    district,
                    style: TextStyle(
                      color: titleColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              );
            }).toList();
          },
          items: districts.map((district) {
            return DropdownMenuItem<String>(
              value: district,
              child: Text(
                district,
                style: TextStyle(
                  color: titleColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }).toList(),
          onChanged: _selectedCity == null
              ? null
              : (value) async {
                  if (value == null) return;

                  setState(() {
                    _selectedDistrict = value;
                  });

                  final searchText =
                      '$value, $_selectedCity, Eastern Province, Saudi Arabia';

                  try {
                    final results = await locationFromAddress(searchText);

                    if (results.isNotEmpty) {
                      final place = results.first;
                      final point = LatLng(place.latitude, place.longitude);

                      setState(() {
                        _selectedLocation = point;
                      });

                      _mapController.move(point, 15);
                    }
                  } catch (e) {
                    debugPrint('District error: $e');
                  }
                },
        ),
      ),
    );
  }

  Widget _categoryDropdown() {
    return _dropdownContainer(
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedCategory,
          isExpanded: true,
          dropdownColor: dropdownColor,
          icon: Icon(Icons.keyboard_arrow_down, color: subTextColor),
          hint: Row(
            children: [
              Icon(Icons.recycling_rounded, color: subTextColor),
              const SizedBox(width: 12),
              Text(
                'Bin Type',
                style: TextStyle(
                  color: hintColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          selectedItemBuilder: (context) {
            return _categories.map((category) {
              return Row(
                children: [
                  _categoryIcon(category),
                  const SizedBox(width: 12),
                  Text(
                    category,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: titleColor,
                    ),
                  ),
                ],
              );
            }).toList();
          },
          items: _categories.map((category) {
            return DropdownMenuItem<String>(
              value: category,
              child: Row(
                children: [
                  _categoryIcon(category),
                  const SizedBox(width: 12),
                  Text(
                    category,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: titleColor,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedCategory = value;
            });
          },
        ),
      ),
    );
  }

  Widget _statusSelector() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.22 : 0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            _isActive ? Icons.check_circle_outline : Icons.cancel_outlined,
            color: _isActive ? primary : Colors.redAccent,
          ),
          const SizedBox(width: 12),
          Text(
            'Bin Status',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: titleColor,
            ),
          ),
          const Spacer(),
          Text(
            _isActive ? 'Active' : 'Inactive',
            style: TextStyle(
              color: _isActive ? primary : Colors.redAccent,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          const SizedBox(width: 8),
          Switch(
            value: _isActive,
            activeColor: primary,
            onChanged: (value) {
              setState(() {
                _isActive = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _mapBox() {
    return Container(
      height: 230,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.20 : 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
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
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: const ['a', 'b', 'c'],
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
                    size: 40,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ],
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
    return AdminBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
                      _cityDropdown(),
                      _districtDropdown(),
                      _categoryDropdown(),
                      _buildInputField(
                        controller: _descriptionController,
                        hint: 'Description / Address',
                        icon: Icons.description_outlined,
                        maxLines: 2,
                        suffixIcon: IconButton(
                          onPressed:
                              _isSearchingAddress ? null : _searchAddress,
                          icon: _isSearchingAddress
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: secondary,
                                  ),
                                )
                              : Icon(
                                  Icons.location_on_outlined,
                                  color: subTextColor,
                                ),
                        ),
                      ),
                      _statusSelector(),
                      const SizedBox(height: 12),
                      Text(
                        'Select Location',
                        style: TextStyle(
                          color: titleColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _mapBox(),
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
        bottomNavigationBar: const AdminBar(selectedIndex: 2),
      ),
    );
  }
}
