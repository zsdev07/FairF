import 'package:flutter/material.dart';
import '../theme/colors.dart';
import 'main_menu_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // TODO: kick off any asset preload / save-data load here later.
    Future.delayed(const Duration(milliseconds: 1400), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MainMenuScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FairFColors.background,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // TODO: swap this for the actual FairF logo asset.
            Text(
              'FairF',
              style: TextStyle(
                color: FairFColors.textPrimary,
                fontSize: 56,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
                shadows: [
                  Shadow(color: FairFColors.cyan.withOpacity(0.6), blurRadius: 24),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const CircularProgressIndicator(color: FairFColors.yellow),
          ],
        ),
      ),
    );
  }
}
