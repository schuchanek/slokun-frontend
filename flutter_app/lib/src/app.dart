import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/map_screen.dart';
import 'screens/profile_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slökun',
      theme: ThemeData(useMaterial3: true),
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
