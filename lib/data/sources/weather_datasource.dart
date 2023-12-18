import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:weather_test/data/data.dart';

class WeatherDataSource {
  Future<ForecastResponse> fetchForecast(LatLng location) async {
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/forecast?lat=${location.latitude}&lon=${location.longitude}&appid=${dotenv.env['OPEN_WEATHER_MAP_API_KEY']}&units=metric',
    );

    final response = await http.get(url);

    log('uri: $url');

    if (response.statusCode == 200 || response.statusCode == 201) {
      log('response: ${response.statusCode}');
      log('response: ${json.decode(response.body)}');
      late final ForecastResponse forecastResponse;

      try {
        forecastResponse = ForecastResponse.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
      } catch (e) {
        log('Error: $e');
      }

      return forecastResponse;
    } else {
      throw Exception('Failed to load forecast');
    }
  }
}
