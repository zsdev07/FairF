import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../widgets/pill_button.dart';
import 'character_screen.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> with SingleTickerProviderStateMixin {
  bool _isLoading = true;
  late final AnimationController _bobController;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      setState(() => _isLoading = false);
    });

    // Gentle idle float — cheap way to make a static render feel alive
    // until real skeletal animation is wired up properly.
    _bobController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _bobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FairFColors.background,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background
          Image.asset(
            'assets/page.png',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(color: FairFColors.background),
          ),
          Container(color: Colors.black.withOpacity(0.25)),

          if (_isLoading)
            const _MenuLoadingOverlay()
          else
            SafeArea(
              child: Stack(
                children: [
                  // Centerpiece character render — gentle idle bob
                  Center(
                    child: AnimatedBuilder(
                      animation: _bobController,
                      builder: (context, child) {
                        final offset = 10 * (0.5 - (_bobController.value - 0.5).abs()) * 2;
                        return Transform.translate(
                          offset: Offset(0, -offset),
                          child: child,
                        );
                      },
                      child: Image.asset(
                        'assets/character_default.png',
                        height: 320,
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.none,
                        errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                      ),
                    ),
                  ),

                  // Top-right: Settings
                  Positioned(
                    top: 16,
                    right: 16,
                    child: PillButton(
                      assetPath: 'assets/button_blue.png',
                      label: 'Settings',
                      width: 130,
                      onTap: () {
                        // TODO: Settings screen (FPS, resolution, map)
                      },
                    ),
                  ),

                  // Bottom-right: Play
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: PillButton(
                      assetPath: 'assets/button_green.png',
                      label: 'Play',
                      width: 170,
                      height: 60,
                      onTap: () {
                        // TODO: open Play side-window (1v1 / 2v2 / Create Room)
                      },
                    ),
                  ),

                  // Left-center: Shop, with Character just below it
                  Positioned(
                    left: 16,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          PillButton(
                            assetPath: 'assets/button_yellow.png',
                            label: 'Shop',
                            width: 140,
                            onTap: () {
                              // TODO: Shop screen
                            },
                          ),
                          const SizedBox(height: 14),
                          PillButton(
                            assetPath: 'assets/button_red.png',
                            label: 'Character',
                            width: 140,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => const CharacterScreen()),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _MenuLoadingOverlay extends StatelessWidget {
  const _MenuLoadingOverlay();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(color: FairFColors.yellow),
          const SizedBox(height: 12),
          Text(
            'Loading...',
            style: TextStyle(color: FairFColors.textSecondary, fontSize: 13, letterSpacing: 1.2),
          ),
        ],
      ),
    );
  }
}
