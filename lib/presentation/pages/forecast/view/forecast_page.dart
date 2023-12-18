import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_test/di/di.dart';
import 'package:weather_test/presentation/presentation.dart';

class ForecastPage extends StatefulWidget {
  const ForecastPage({
    required this.cityName,
    required this.location,
    super.key,
  });

  final String cityName;
  final LatLng location;

  @override
  State<ForecastPage> createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  @override
  void initState() {
    super.initState();
    sl<ForecastCubit>().fetchForecast(widget.location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Forecast for ${widget.cityName}')),
      body: BlocBuilder<ForecastCubit, ForecastState>(
        builder: (context, state) {
          if (state is ForecastLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ForecastLoaded) {
            return ListView.builder(
              itemCount: state.forecast.forecasts.length,
              itemBuilder: (context, index) {
                final forecast = state.forecast.forecasts[index];
                return ListTile(
                  leading: Text(forecast.date),
                  title: Text('${forecast.temperature}°C'),
                  subtitle: Text(forecast.weatherDescription),
                );
              },
            );
          } else if (state is ForecastError) {
            return Text('Error: ${state.message}');
          }
          return const Text('Enter a location to see the forecast');
        },
      ),
    );
  }
}
