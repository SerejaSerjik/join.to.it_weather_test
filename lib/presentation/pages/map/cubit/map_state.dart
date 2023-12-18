part of 'map_cubit.dart';

class MapState {
  MapState({
    this.location,
    this.isLoading = false,
    this.errorMessage,
    this.nearestCityName,
    this.nearestCityLocation,
  });

  final LatLng? location;
  final bool isLoading;
  final String? errorMessage;
  final String? nearestCityName;
  final LatLng? nearestCityLocation;

  MapState copyWith({
    LatLng? location,
    bool? isLoading,
    String? errorMessage,
    String? nearestCityName,
    LatLng? nearestCityLocation,
  }) {
    return MapState(
      location: location ?? this.location,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      nearestCityName: nearestCityName ?? this.nearestCityName,
      nearestCityLocation: nearestCityLocation ?? this.nearestCityLocation,
    );
  }
}
