// ignore_for_file: lines_longer_than_80_chars

import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:weather_test/data/data.dart';

class LocationService {
  final Location _location = Location();

  Future<LatLng> getCurrentLocation() async {
    final locationData = await _location.getLocation();

    return LatLng(locationData.latitude!, locationData.longitude!);
  }

  Future<GeocodingResponse> getCityGeocoding(LatLng position) async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=${dotenv.env['GOOGLE_MAPS_API_KEY']}',
    );
    final response = await http.get(url);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final geocodingResponse = GeocodingResponse.fromJson(
        json.decode(response.body) as Map<String, dynamic>,
      );

      return geocodingResponse;
    } else {
      throw Exception('Failed to load city name');
    }
  }
}
