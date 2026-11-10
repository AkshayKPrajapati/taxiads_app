import 'package:flutter/material.dart';
import 'package:taxiads/splashscreen.dart';

void main() {
  runApp(const MyApp());


  
}

/// ---------------------------------------------------------------------------
/// APP THEME & ENTRY POINT
/// ---------------------------------------------------------------------------
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // App Color Palette: Yellow, Black, and White
  static const Color yellow = Color(0xFFFFD600); // Taxi Yellow
  static const Color black = Color(0xFF121212);  // Rich Dark Black
  static const Color white = Color(0xFFFFFFFF);  // Pure White

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TaxiAds',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: black,
        colorScheme: const ColorScheme.dark(
          primary: yellow,
          onPrimary: black,
          secondary: yellow,
          onSecondary: black,
          surface: Color(0xFF1E1E1E),
          onSurface: white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: black,
          foregroundColor: yellow,
          elevation: 0,
          centerTitle: true,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: yellow,
          foregroundColor: black,
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: const Color(0xFF1E1E1E),
          indicatorColor: yellow,
          iconTheme: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(color: black);
            }
            return const IconThemeData(color: white);
          }),
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const TextStyle(color: yellow, fontWeight: FontWeight.bold);
            }
            return const TextStyle(color: Colors.white70);
          }),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
