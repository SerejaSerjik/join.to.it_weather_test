import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_test/presentation/presentation.dart';

enum RoutePath {
  main(path: '/'),
  map(path: '/map'),
  search(path: '/search'),
  forecast(path: '/forecast');

  const RoutePath({required this.path});
  final String path;
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRoute {
  static final GoRouter router = GoRouter(
    initialLocation: RoutePath.main.path,
    //debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    redirect: (context, state) {
      return null;
    },
    routes: [
      GoRoute(
        name: RoutePath.main.name,
        path: RoutePath.main.path,
        builder: (context, state) {
          return const MainPage();
        },
      ),
      GoRoute(
        name: RoutePath.forecast.name,
        path: RoutePath.forecast.path,
        builder: (context, state) {
          return ForecastPage(
            cityName: (state.extra! as List<Object?>)[0]! as String,
            location: (state.extra! as List<Object?>)[1]! as LatLng,
          );
        },
      ),
    ],
    errorBuilder: (context, state) => const Placeholder(),
  );
}
