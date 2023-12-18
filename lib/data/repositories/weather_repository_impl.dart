import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_test/data/data.dart';
import 'package:weather_test/domain/domain.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  WeatherRepositoryImpl(this.weatherDataSource);

  final WeatherDataSource weatherDataSource;

  @override
  Future<ForecastEntity> getForecast(LatLng location) async {
    final forecastResponse = await weatherDataSource.fetchForecast(location);
    return forecastResponse.toEntity();
  }
}
