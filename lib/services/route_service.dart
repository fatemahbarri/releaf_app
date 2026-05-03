import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class RouteService {
  static const String _apiKey =
      'eyJvcmciOiI1YjNjZTM1OTc4NTExMTAwMDFjZjYyNDgiLCJpZCI6IjdhZDNhYzc2MzUxZDQxMjhiMzcyNzBjMGJmZDU2NjA4IiwiaCI6Im11cm11cjY0In0=';

  static Future<List<LatLng>> getRoute({
    required LatLng start,
    required LatLng end,
  }) async {
    final url = Uri.parse(
      'https://api.openrouteservice.org/v2/directions/driving-car/geojson',
    );

    final response = await http.post(
      url,
      headers: {
        'Authorization': _apiKey,
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'coordinates': [
          [start.longitude, start.latitude],
          [end.longitude, end.latitude],
        ],
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load route');
    }

    final data = jsonDecode(response.body);

    final coords = data['features'][0]['geometry']['coordinates'] as List;

    return coords.map((point) {
      return LatLng(
        point[1].toDouble(),
        point[0].toDouble(),
      );
    }).toList();
  }
}
