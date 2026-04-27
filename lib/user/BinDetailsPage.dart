import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:releaf_app/widgets/app_background.dart';
import 'package:releaf_app/widgets/releaf_ui.dart';

import 'package:releaf_app/user/HomePageUser.dart';
import 'package:releaf_app/user/LocationPage.dart';
import 'package:releaf_app/user/Profile.dart';
import 'package:releaf_app/classification/image_classifier_screen.dart';

class BinDetailsPage extends StatefulWidget {
  final String locationName;
  final String address;
  final String category;
  final double latitude;
  final double longitude;

  const BinDetailsPage({
    super.key,
    required this.locationName,
    required this.address,
    required this.category,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<BinDetailsPage> createState() => _BinDetailsPageState();
}

class _BinDetailsPageState extends State<BinDetailsPage> {
  void _onBottomTap(int index) {
    if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LocationPage(),
        ),
      );
    }

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomePageUser(),
        ),
      );
    }

    if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const ImageClassifierScreen(),
        ),
      );
    }

    if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const Profile(
            name: 'User',
            email: 'user@email.com',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final LatLng selectedLocation = LatLng(
      widget.latitude,
      widget.longitude,
    );

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              ReLeafHeader(
                title: widget.locationName,
                subtitle: widget.address,
                icon: Icons.location_on_rounded,
                showBackButton: true,
                onBack: () => Navigator.pop(context),
              ),

              ReLeafInfoBox(
                text: 'Category: ${widget.category}',
                icon: Icons.recycling_rounded,
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                  child: ReLeafCard(
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
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
                                  size: 46,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        bottomNavigationBar: ReLeafBottomBar(
          selectedIndex: 2,
          onTap: _onBottomTap,
        ),
      ),
    );
  }
}