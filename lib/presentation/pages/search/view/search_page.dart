import 'package:fl_geocoder/fl_geocoder.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_test/di/di.dart';
import 'package:weather_test/presentation/presentation.dart';
import 'package:weather_test/utils.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final TextEditingController controller;
  final addresses = <Result>[];

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: "Kotsyubyns'ke");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Text(
            'Geocode Address Query',
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
        ),
        TextFormField(
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.streetAddress,
          enabled: true,
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Address',
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.blue, width: 2),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: SubmitButton(
            onPressed: () async {
              final query = controller.text;
              try {
                final results =
                    await sl<FlGeocoder>().findAddressesFromAddress(query);

                addresses
                  ..clear()
                  ..addAll(results);
                setState(() {});
              } on GeocodeFailure catch (e) {
                showSnackBarColored(
                  e.message ?? 'Unknown error occured.',
                  SnackBarType.error,
                );
              } catch (e) {
                showSnackBarColored(e.toString(), SnackBarType.error);
              }
            },
            text: 'Search',
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Text(
            'Result/s:',
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: addresses.length,
          itemBuilder: (context, index) {
            final address = addresses[index];

            return InkWell(
              onTap: () {
                context.pushNamed(
                  RoutePath.forecast.name,
                  extra: [
                    address.addressComponents.first.longName,
                    LatLng(
                      address.geometry.location.latitude,
                      address.geometry.location.longitude,
                    ),
                  ],
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  address.addressComponents.first.longName,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
