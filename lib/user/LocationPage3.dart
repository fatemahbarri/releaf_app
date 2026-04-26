import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../widgets/releaf_ui.dart';

class LocationPage3 extends StatefulWidget {
  final String locationName;
  final String address;
  final String category;
  final double latitude;
  final double longitude;

  const LocationPage3({
    super.key,
    required this.locationName,
    required this.address,
    required this.category,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<LocationPage3> createState() => _LocationPage3State();
}

class _LocationPage3State extends State<LocationPage3> {
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
                color: selected
                    ? ReLeafColors.primary.withOpacity(0.25)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                icon,
                color: selected
                    ? ReLeafColors.textDark
                    : ReLeafColors.textMedium,
                size: 27,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: selected
                    ? ReLeafColors.textDark
                    : ReLeafColors.textMedium,
                fontWeight: selected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final LatLng selectedLocation = LatLng(
      widget.latitude,
      widget.longitude,
    );

    return Scaffold(
      backgroundColor: ReLeafColors.background,
      body: SafeArea(
        child: Column(
          children: [
            ReLeafHeader(
              title: widget.category,
              subtitle: 'Selected bin location',
              icon: Icons.location_on_rounded,
              showBackButton: true,
              onBack: () => Navigator.pop(context),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReLeafCard(
                      padding: EdgeInsets.zero,
                      margin: EdgeInsets.zero,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: SizedBox(
                          height: 330,
                          width: double.infinity,
                          child: FlutterMap(
                            options: MapOptions(
                              initialCenter: selectedLocation,
                              initialZoom: 16,
                            ),
                            children: [
                              TileLayer(
                                urlTemplate:
                                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                                subdomains: const ['a', 'b', 'c'],
                                userAgentPackageName: 'com.example.releaf_app',
                              ),
                              MarkerLayer(
                                markers: [
                                  Marker(
                                    point: selectedLocation,
                                    width: 80,
                                    height: 80,
                                    child: const Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                      size: 42,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    ReLeafCard(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.locationName,
                            style: ReLeafTextStyles.title.copyWith(
                              fontSize: 20,
                            ),
                          ),

                          const SizedBox(height: 12),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                color: ReLeafColors.textDark,
                                size: 21,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  widget.address,
                                  style: ReLeafTextStyles.body.copyWith(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 14),

                          ReLeafInfoBox(
                            text: 'Category: ${widget.category}',
                            icon: Icons.recycling_rounded,
                          ),
                        ],
                      ),
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