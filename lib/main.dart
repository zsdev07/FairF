import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/colors.dart';
import 'screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // FairF is a game — lock to landscape and go fullscreen immersive.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

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
