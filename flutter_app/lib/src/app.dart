import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/map_screen.dart';
import 'screens/profile_screen.dart';

const Color kPrimary = Color(0xFF2A6B8F); // Mély kék
const Color kSecondary = Color(0xFFE8B8A8); // Meleg rozé
const Color kAccent = Color(0xFFF5A623); // Meleg sárga
const Color kBackground = Color(0xFFF9F7F4); // Krém

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: kPrimary,
      primary: kPrimary,
      secondary: kSecondary,
      background: kBackground,
      brightness: Brightness.light,
    );

    return MaterialApp(
      title: 'Slökun',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: kBackground,
        appBarTheme: AppBarTheme(backgroundColor: kPrimary, foregroundColor: Colors.white),
        elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(backgroundColor: kPrimary)),
        filledButtonTheme: FilledButtonThemeData(style: FilledButton.styleFrom(backgroundColor: kAccent)),
      ),
      darkTheme: ThemeData.dark(),
      home: const WelcomeScreen(),
      routes: {
        '/map': (_) => const MapScreen(),
        '/profile': (_) => const ProfileScreen(),
      },
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
