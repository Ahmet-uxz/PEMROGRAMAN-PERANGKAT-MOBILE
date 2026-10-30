import 'package:flutter/material.dart';
import 'screens/home_events_screen.dart';

void main() => runApp(const NusaEventApp());

class NusaEventApp extends StatelessWidget {
  const NusaEventApp({super.key});

  @override
  Widget build(BuildContext context) {
    const seed = Color(0xFF3157D5);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NusaEvent Hub',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: seed),
        scaffoldBackgroundColor: const Color(0xFFF6F7FB),
        appBarTheme: const AppBarTheme(centerTitle: false),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      home: const HomeEventsScreen(),
    );
  }
}