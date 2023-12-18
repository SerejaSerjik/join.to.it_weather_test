class ForecastEntity {
  ForecastEntity({required this.cityName, required this.forecasts});

  final String cityName;
  final List<DailyWeatherForecast> forecasts;
}

class DailyWeatherForecast {
  DailyWeatherForecast({
    required this.date,
    required this.temperature,
    required this.weatherMain,
    required this.weatherDescription,
  });

  final String date;
  final double temperature;
  final String weatherMain;
  final String weatherDescription;
}
