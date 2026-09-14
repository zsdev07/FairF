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
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Full-bleed logo — it already has its own dark textured background baked in.
          Image.asset(
            'assets/logo.png',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Center(
                child: Text(
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
              );
            },
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: const Center(
              child: CircularProgressIndicator(color: FairFColors.yellow),
            ),
          ),
        ],
      ),
    );
  }
}
