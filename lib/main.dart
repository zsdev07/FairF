import 'package:flutter/material.dart';
import 'theme/colors.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const FairFApp());
}

class FairFApp extends StatelessWidget {
  const FairFApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FairF',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: FairFColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: FairFColors.yellow,
          secondary: FairFColors.cyan,
          brightness: Brightness.dark,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
