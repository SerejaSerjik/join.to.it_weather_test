// ignore_for_file: avoid_dynamic_calls

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:weather_test/domain/domain.dart';

class ForecastResponse {
  ForecastResponse({
    required this.list,
    required this.city,
  });

  factory ForecastResponse.fromJson(Map<String, dynamic> json) {
    return ForecastResponse(
      list: List<WeatherForecast>.from(
        (json['list'] as List<dynamic>).map(
          (x) => WeatherForecast.fromJson(x as Map<String, dynamic>),
        ),
      ),
      city: CityInfo.fromJson(json['city'] as Map<String, dynamic>),
    );
  }

  final List<WeatherForecast> list;
  final CityInfo city;

  ForecastEntity toEntity() {
    // Create a map to group forecasts by their date
    final groupedByDate = <DateTime, List<WeatherForecast>>{};

    for (final forecast in list) {
      final date = DateTime.fromMillisecondsSinceEpoch(forecast.dt * 1000);
      final dateOnly =
          DateTime(date.year, date.month, date.day); // Removes time part

      if (!groupedByDate.containsKey(dateOnly)) {
        groupedByDate[dateOnly] = [];
      }
      groupedByDate[dateOnly]!.add(forecast);
    }

    // Select the first forecast for each day
    final dailyForecasts = groupedByDate.entries.map((entry) {
      final forecast = entry.value.first;

      final formattedDate = DateFormat('yyyy-MM-dd').format(entry.key);

      return DailyWeatherForecast(
        date: formattedDate,
        temperature: forecast.main.temp,
        weatherMain: forecast.weather[0].main,
        weatherDescription: forecast.weather[0].description,
      );
    }).toList();

    return ForecastEntity(
      cityName: city.name,
      forecasts: dailyForecasts,
    );
  }
}

class WeatherForecast {
  WeatherForecast({
    required this.dt,
    required this.main,
    required this.weather,
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    return WeatherForecast(
      dt: json['dt'] as int,
      main: MainWeatherInfo.fromJson(json['main'] as Map<String, dynamic>),
      weather: List<WeatherInfo>.from(
        (json['weather'] as List<dynamic>).map(
          (x) => WeatherInfo.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }
  final int dt;
  final MainWeatherInfo main;
  final List<WeatherInfo> weather;
}

class MainWeatherInfo {
  MainWeatherInfo({required this.temp});

  factory MainWeatherInfo.fromJson(Map<String, dynamic> json) {
    final temp = json['temp'];
    return MainWeatherInfo(
      temp: (temp is int) ? temp.toDouble() : temp as double,
    );
  }
  final double temp;
}

class WeatherInfo {
  WeatherInfo({
    required this.main,
    required this.description,
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      main: json['main'] as String,
      description: json['description'] as String,
    );
  }
  final String main;
  final String description;
}

class CityInfo {
  CityInfo({
    required this.name,
    required this.coord,
  });

  factory CityInfo.fromJson(Map<String, dynamic> json) {
    return CityInfo(
      name: json['name'] as String,
      coord: LatLng(
        json['coord']['lat'] as double,
        json['coord']['lon'] as double,
      ),
    );
  }
  final String name;
  final LatLng coord;
}
