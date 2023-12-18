import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_test/bootstrap.dart';
import 'package:weather_test/di/di.dart';
import 'package:weather_test/presentation/presentation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();

  await serviceLocator();

  await bootstrap(() => const App());
}
