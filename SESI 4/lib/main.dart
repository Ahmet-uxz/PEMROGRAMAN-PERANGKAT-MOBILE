
import 'package:flutter/material.dart';

import 'models/tour_package.dart';
import 'routes/app_routes.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/detail_screen.dart';
import 'screens/booking_screen.dart';
import 'screens/not_found_screen.dart';

void main() {
  runApp(const NusaTravelApp());
}

class NusaTravelApp extends StatelessWidget {
  const NusaTravelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NusaTravel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
      ),

      initialRoute: AppRoutes.splash,

      routes: {
        AppRoutes.splash: (context) => const SplashScreen(),
        AppRoutes.home: (context) => const HomeScreen(),
      },

      onGenerateRoute: (settings) {
        if (settings.name == AppRoutes.detail) {
          final package = settings.arguments;

          if (package is TourPackage) {
            return MaterialPageRoute(
              builder: (context) => DetailScreen(
                tourPackage: package,
              ),
              settings: settings,
            );
          }

          return MaterialPageRoute(
            builder: (context) => const NotFoundScreen(),
          );
        }

        if (settings.name == AppRoutes.booking) {
          final package = settings.arguments;

          if (package is TourPackage) {
            return MaterialPageRoute(
              builder: (context) => BookingScreen(
                tourPackage: package,
              ),
              settings: settings,
            );
          }

          return MaterialPageRoute(
            builder: (context) => const NotFoundScreen(),
          );
        }

        return null;
      },

      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const NotFoundScreen(),
        );
      },
    );
  }
}
