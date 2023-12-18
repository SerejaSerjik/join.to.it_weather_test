// ignore_for_file: one_member_abstracts

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_test/data/data.dart';
import 'package:weather_test/domain/domain.dart';

class LocationRepositoryImpl implements LocationRepository {
  LocationRepositoryImpl(this.locationService);

  final LocationService locationService;

  @override
  Future<LatLng> getCurrentLocation() {
    return locationService.getCurrentLocation();
  }

  @override
  Future<GeocodingResponse> getCityGeocoding(LatLng position) {
    return locationService.getCityGeocoding(position);
  }
}
