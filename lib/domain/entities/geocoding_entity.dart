import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeocodingEntity {
  GeocodingEntity({
    required this.cityName,
    required this.location,
  });

  final String cityName;
  final LatLng location;
}
