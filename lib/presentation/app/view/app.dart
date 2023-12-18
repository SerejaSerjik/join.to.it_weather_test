import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_test/di/di.dart';
import 'package:weather_test/l10n/l10n.dart';
import 'package:weather_test/presentation/presentation.dart';
import 'package:weather_test/utils.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<MapCubit>(),
        ),
        BlocProvider(
          create: (_) => sl<ForecastCubit>(),
        ),
      ],
      child: MaterialApp.router(
        scaffoldMessengerKey: globalScaffoldMessengerKey,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          useMaterial3: true,
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerDelegate: AppRoute.router.routerDelegate,
        routeInformationParser: AppRoute.router.routeInformationParser,
        routeInformationProvider: AppRoute.router.routeInformationProvider,
      ),
    );
  }
}
