import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_test/domain/domain.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit(
    this._getCurrentLocationUseCase,
    this._getCityGeocodingUseCase,
  ) : super(MapState());

  final GetCurrentLocationUseCase _getCurrentLocationUseCase;
  final GetCityGeocodingUseCase _getCityGeocodingUseCase;

  Future<void> loadCurrentLocation() async {
    emit(state.copyWith(isLoading: true));
    try {
      final location = await _getCurrentLocationUseCase.execute();

      emit(state.copyWith(location: location, isLoading: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }

  Future<void> fetchNearestCity(LatLng position) async {
    emit(state.copyWith(isLoading: true));
    try {
      final geocoding = await _getCityGeocodingUseCase.execute(position);

      emit(
        state.copyWith(
          nearestCityName: geocoding.cityName,
          nearestCityLocation: geocoding.location,
        ),
      );
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }
}
