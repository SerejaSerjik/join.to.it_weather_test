import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_test/domain/domain.dart';

part 'forecast_state.dart';

class ForecastCubit extends Cubit<ForecastState> {
  ForecastCubit(this._getForecastUseCase) : super(ForecastInitial());

  final GetForecastUseCase _getForecastUseCase;

  Future<void> fetchForecast(LatLng location) async {
    try {
      emit(ForecastLoading());
      final forecast = await _getForecastUseCase.execute(location);
      emit(ForecastLoaded(forecast));
    } catch (e) {
      emit(ForecastError(e.toString()));
    }
  }
}
