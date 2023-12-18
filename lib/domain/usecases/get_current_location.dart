import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_test/domain/domain.dart';

class GetCurrentLocationUseCase {
  const GetCurrentLocationUseCase(this._locationRepository);

  final LocationRepository _locationRepository;

  Future<LatLng> execute() async {
    return _locationRepository.getCurrentLocation();
  }
}
