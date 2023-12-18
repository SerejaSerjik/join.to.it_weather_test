import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_test/domain/domain.dart';

class GeocodingResponse {
  GeocodingResponse({
    required this.results,
    required this.status,
  });

  factory GeocodingResponse.fromJson(Map<String, dynamic> json) {
    return GeocodingResponse(
      results: List<GeocodedLocation>.from(
        (json['results'] as List<dynamic>).map(
          (x) => GeocodedLocation.fromJson(x as Map<String, dynamic>),
        ),
      ),
      status: json['status'] as String,
    );
  }

  GeocodingEntity toEntity() {
    late String cityName;

    for (final result in results) {
      for (final component in result.addressComponents) {
        if (component.types.contains('locality') &&
            component.types.contains('political')) {
          cityName = component.longName; // Return the city name
        }
      }
    }

    return GeocodingEntity(
      cityName: cityName,
      location: LatLng(
        results[0].geometry.location.lat,
        results[0].geometry.location.lng,
      ),
    );
  }

  final List<GeocodedLocation> results;
  final String status;
}

class GeocodedLocation {
  GeocodedLocation({
    required this.addressComponents,
    required this.formattedAddress,
    required this.geometry,
  });

  factory GeocodedLocation.fromJson(Map<String, dynamic> json) {
    return GeocodedLocation(
      addressComponents: List<AddressComponent>.from(
        (json['address_components'] as List<dynamic>).map(
          (x) => AddressComponent.fromJson(x as Map<String, dynamic>),
        ),
      ),
      formattedAddress: json['formatted_address'] as String,
      geometry: Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
    );
  }

  final List<AddressComponent> addressComponents;
  final String formattedAddress;
  final Geometry geometry;
}

class AddressComponent {
  AddressComponent({
    required this.longName,
    required this.shortName,
    required this.types,
  });

  factory AddressComponent.fromJson(Map<String, dynamic> json) {
    return AddressComponent(
      longName: json['long_name'] as String,
      shortName: json['short_name'] as String,
      types: List<String>.from(json['types'] as List<dynamic>),
    );
  }

  final String longName;
  final String shortName;
  final List<String> types;
}

class Geometry {
  Geometry({
    required this.location,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) {
    return Geometry(
      location:
          LocationResponse.fromJson(json['location'] as Map<String, dynamic>),
    );
  }

  final LocationResponse location;
}

class LocationResponse {
  LocationResponse({required this.lat, required this.lng});

  factory LocationResponse.fromJson(Map<String, dynamic> json) {
    return LocationResponse(
      lat: json['lat'] as double,
      lng: json['lng'] as double,
    );
  }

  final double lat;
  final double lng;
}
