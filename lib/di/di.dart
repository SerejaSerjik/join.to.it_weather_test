import 'dart:developer';

import 'package:fl_geocoder/fl_geocoder.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_test/data/data.dart';
import 'package:weather_test/domain/domain.dart';
import 'package:weather_test/presentation/presentation.dart';

GetIt sl = GetIt.instance;

Future<void> serviceLocator() async {
  log('Initiating Service Locator');

  sl.registerSingleton<FlGeocoder>(
    FlGeocoder(dotenv.env['GOOGLE_MAPS_API_KEY']!),
  );

  dataSources();
  repositories();
  services();
  useCase();
  bloc();
  cubit();
}

void dataSources() {
  sl.registerLazySingleton<WeatherDataSource>(
    WeatherDataSource.new,
  );
}

void repositories() {
  sl
    ..registerLazySingleton<LocationRepository>(
      () => LocationRepositoryImpl(sl()),
    )
    ..registerLazySingleton<WeatherRepository>(
      () => WeatherRepositoryImpl(sl()),
    );
}

void services() {
  sl.registerLazySingleton<LocationService>(
    LocationService.new,
  );
}

void useCase() {
  sl
    ..registerLazySingleton(() => GetCurrentLocationUseCase(sl()))
    ..registerLazySingleton(() => GetCityGeocodingUseCase(sl()))
    ..registerLazySingleton(() => GetForecastUseCase(sl()));
}

void bloc() {}

void cubit() {
  sl
    ..registerLazySingleton(
      () => MapCubit(
        sl(),
        sl(),
      ),
    )
    ..registerLazySingleton(
      () => ForecastCubit(
        sl(),
      ),
    );
}
