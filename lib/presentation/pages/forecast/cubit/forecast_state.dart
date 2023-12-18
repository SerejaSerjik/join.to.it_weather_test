part of 'forecast_cubit.dart';

abstract class ForecastState {}

class ForecastInitial extends ForecastState {}

class ForecastLoading extends ForecastState {}

class ForecastLoaded extends ForecastState {
  ForecastLoaded(this.forecast);

  final ForecastEntity forecast;
}

class ForecastError extends ForecastState {
  ForecastError(this.message);

  final String message;
}
