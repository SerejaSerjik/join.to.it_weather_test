// ignore_for_file: one_member_abstracts

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_test/data/data.dart';

abstract class LocationRepository {
  Future<LatLng> getCurrentLocation();
  Future<GeocodingResponse> getCityGeocoding(LatLng position);
}
