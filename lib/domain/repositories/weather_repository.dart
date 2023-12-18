// ignore_for_file: one_member_abstracts

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_test/domain/domain.dart';

abstract class WeatherRepository {
  Future<ForecastEntity> getForecast(LatLng location);
}
