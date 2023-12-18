import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_test/domain/domain.dart';

class GetForecastUseCase {
  GetForecastUseCase(this.repository);

  final WeatherRepository repository;

  Future<ForecastEntity> execute(LatLng location) async {
    return repository.getForecast(location);
  }
}
