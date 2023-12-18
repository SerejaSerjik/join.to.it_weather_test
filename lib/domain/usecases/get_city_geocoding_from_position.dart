import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_test/domain/domain.dart';

class GetCityGeocodingUseCase {
  GetCityGeocodingUseCase(this._locationRepository);
  final LocationRepository _locationRepository;

  Future<GeocodingEntity> execute(LatLng position) async {
    final geocodingResponse =
        await _locationRepository.getCityGeocoding(position);

    return geocodingResponse.toEntity();
  }
}
