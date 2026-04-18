import 'package:flutter/material.dart';
import 'LocationPage3.dart';

class RecyclingLocation {
  final String name;
  final String address;
  final String category;
  final double latitude;
  final double longitude;

  const RecyclingLocation({
    required this.name,
    required this.address,
    required this.category,
    required this.latitude,
    required this.longitude,
  });
}

class LocationPage2 extends StatefulWidget {
  final String category;

  const LocationPage2({
    super.key,
    required this.category,
  });

  @override
  State<LocationPage2> createState() => _LocationPage2State();
}

class _LocationPage2State extends State<LocationPage2> {
  final TextEditingController _searchController = TextEditingController();

  int _selectedBottomNavIndex = 2;
  String _searchText = '';

  final List<RecyclingLocation> _allLocations = const [
    RecyclingLocation(
      name: 'Khobar Recycling Center',
      address: 'Prince Faisal Bin Fahd Road, Al Khobar',
      category: 'Plastic',
      latitude: 26.2794,
      longitude: 50.2083,
    ),
    RecyclingLocation(
      name: 'Eastern Eco Drop-Off',
      address: 'King Fahd Street, Al Thuqbah District',
      category: 'Plastic',
      latitude: 26.2868,
      longitude: 50.1897,
    ),
    RecyclingLocation(
      name: 'Corniche Waste Sorting',
      address: 'Khobar Corniche Road, Al Bahar Area',
      category: 'Plastic',
      latitude: 26.3092,
      longitude: 50.2205,
    ),
    RecyclingLocation(
      name: 'Bayfront Recycle Center',
      address: 'Seaside Road, Al Khobar Corniche Extension',
      category: 'Plastic',
      latitude: 26.3205,
      longitude: 50.2261,
    ),
    RecyclingLocation(
      name: 'Glass Collection Point',
      address: 'Prince Turki Road, Al Khobar',
      category: 'Glass',
      latitude: 26.2954,
      longitude: 50.2010,
    ),
    RecyclingLocation(
      name: 'Green Paper Hub',
      address: 'King Saud Street, Dammam',
      category: 'Paper',
      latitude: 26.4207,
      longitude: 50.0888,
    ),
    RecyclingLocation(
      name: 'Metal Recovery Point',
      address: 'Industrial Area, Dammam',
      category: 'Metal',
      latitude: 26.3927,
      longitude: 49.9776,
    ),
    RecyclingLocation(
      name: 'Cardboard Station',
      address: 'Al Ulaya District, Khobar',
      category: 'Cardboard',
      latitude: 26.3008,
      longitude: 50.1836,
    ),
    RecyclingLocation(
      name: 'General Waste Bin',
      address: 'Campus Road, University Area',
      category: 'Trash',
      latitude: 26.3072,
      longitude: 50.1496,
    ),
  ];

  List<RecyclingLocation> get _filteredLocations {
    return _allLocations.where((location) {
      final matchesCategory =
          location.category.toLowerCase() == widget.category.toLowerCase();

      final query = _searchText.trim().toLowerCase();
      final matchesSearch = query.isEmpty ||
          location.name.toLowerCase().contains(query) ||
          location.address.toLowerCase().contains(query);

      return matchesCategory && matchesSearch;
    }).toList();
  }

  void _handleGo(RecyclingLocation location) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LocationPage3(
          locationName: location.name,
          address: location.address,
          category: location.category,
          latitude: location.latitude,
          longitude: location.longitude,
        ),
      ),
    );
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _selectedBottomNavIndex = index;
    });

    switch (index) {
      case 0:
        debugPrint('Go to Home');
        break;
      case 1:
        debugPrint('Go to Camera');
        break;
      case 2:
        debugPrint('Already in Bins');
        break;
      case 3:
        debugPrint('Go to Profile');
        break;
    }
  }

  Widget _buildBottomNavItem({
    required IconData icon,
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
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
      ),
    );
  }

  Widget _buildLocationCard(RecyclingLocation location) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFD6D6D6)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFE7F4E4),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.location_on_outlined,
              color: Color(0xFF4E9F67),
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  location.name,
                  style: const TextStyle(
                    color: Color(0xFF2F3A31),
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  location.address,
                  style: const TextStyle(
                    color: Color(0xFF6C6C6C),
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () => _handleGo(location),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFB8D97A),
              foregroundColor: const Color(0xFF4F5B46),
              elevation: 0,
              padding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'Go',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
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
    final isTrash = widget.category.toLowerCase() == 'trash';

    return Scaffold(
      backgroundColor: const Color(0xFFF3FFE2),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Color(0xFF6F8F74),
                            size: 28,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(right: 48),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: const Color(0xFF4E9F67),
                              borderRadius: BorderRadius.circular(28),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x22000000),
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Text(
                              isTrash
                                  ? 'Trash (non-recyclables)'
                                  : widget.category,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isTrash ? 20 : 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: const Color(0xFFD9D9D9)),
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            _searchText = value;
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: 'Search location',
                          hintStyle: TextStyle(
                            color: Color(0xFFB3B3B3),
                            fontSize: 16,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Color(0xFF2F3A31),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 13),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE7F4E4),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFCCE0C7)),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.info_outline,
                            color: Color(0xFF4E6757),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Showing available ${widget.category.toLowerCase()} bin locations.',
                              style: const TextStyle(
                                color: Color(0xFF4E6757),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '${_filteredLocations.length} location${_filteredLocations.length == 1 ? '' : 's'} found',
                      style: const TextStyle(
                        color: Color(0xFF675F5A),
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 14),
                    if (_filteredLocations.isEmpty)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFD6D6D6)),
                        ),
                        child: const Text(
                          'No matching locations found for this category.',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF5B5656),
                          ),
                        ),
                      )
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _filteredLocations.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: 14),
                        itemBuilder: (context, index) {
                          final location = _filteredLocations[index];
                          return _buildLocationCard(location);
                        },
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
                    selected: _selectedBottomNavIndex == 0,
                    onTap: () => _onBottomNavTap(0),
                  ),
                  _buildBottomNavItem(
                    icon: Icons.camera_alt_outlined,
                    label: 'Camera',
                    selected: _selectedBottomNavIndex == 1,
                    onTap: () => _onBottomNavTap(1),
                  ),
                  _buildBottomNavItem(
                    icon: Icons.location_on_outlined,
                    label: 'Bins',
                    selected: _selectedBottomNavIndex == 2,
                    onTap: () => _onBottomNavTap(2),
                  ),
                  _buildBottomNavItem(
                    icon: Icons.settings_outlined,
                    label: 'Profile',
                    selected: _selectedBottomNavIndex == 3,
                    onTap: () => _onBottomNavTap(3),
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