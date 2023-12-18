import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_test/di/di.dart';
import 'package:weather_test/presentation/presentation.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    sl<MapCubit>().loadCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(
      bloc: sl<MapCubit>(),
      builder: (context, state) {
        if (state.location == null) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: state.location!,
              zoom: 14.4746,
            ),
            onMapCreated: _controller.complete,
            myLocationEnabled: true,
            // liteModeEnabled: true,
            markers: Set<Marker>.of(_markers),
            onLongPress: (position) {
              _addMarker(context, position);
            },
          );
        }
      },
    );
  }

  // Future<void> _moveCamera(LatLng position) async {
  //   final controller = await _controller.future;
  //   await controller.animateCamera(CameraUpdate.newLatLng(position));
  // }

  Future<void> _addMarker(BuildContext context, LatLng position) async {
    await sl<MapCubit>().fetchNearestCity(position);

    final markerIdVal =
        'marker_id_${_markers.length}_${sl<MapCubit>().state.nearestCityName}';
    final markerId = MarkerId(markerIdVal);

    setState(() {
      final marker = Marker(
        markerId: markerId,
        position: position,
        infoWindow: InfoWindow(
          title: markerIdVal,
          snippet: '*',
          onTap: () {
            context.pushNamed(
              RoutePath.forecast.name,
              extra: [
                sl<MapCubit>().state.nearestCityName,
                sl<MapCubit>().state.nearestCityLocation,
              ],
            );
          },
        ),
      );

      _markers.add(marker);
    });
  }
}
