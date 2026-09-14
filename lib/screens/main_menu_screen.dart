import 'package:flutter/material.dart';
import '../theme/colors.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Mirrors the FF/Stumble Guys pattern: a short loading beat while the
    // lobby (event data, player profile, etc.) would actually be fetched.
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FairFColors.background,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image (assets/page.png)
          Image.asset(
            'assets/page.png',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(color: FairFColors.background),
          ),
          Container(color: Colors.black.withOpacity(0.35)), // readability scrim
          if (_isLoading)
            const _MenuLoadingOverlay()
          else
            SafeArea(
              child: Row(
                children: [
                  // Left nav: Play / Characters / Shop / Settings
                  SizedBox(
                    width: 120,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
                      child: Column(
                        children: [
                          _NavButton(label: 'Play', icon: Icons.play_arrow_rounded, onTap: () {
                            // TODO: open Play side-window (1v1 / 2v2 / Create Room)
                          }),
                          const SizedBox(height: 16),
                          _NavButton(label: 'Characters', icon: Icons.person_rounded, onTap: () {
                            // TODO: Characters screen
                          }),
                          const SizedBox(height: 16),
                          _NavButton(label: 'Shop', icon: Icons.storefront_rounded, onTap: () {
                            // TODO: Shop screen
                          }),
                          const SizedBox(height: 16),
                          _NavButton(label: 'Settings', icon: Icons.settings_rounded, onTap: () {
                            // TODO: Settings screen (FPS, resolution, map)
                          }),
                        ],
                      ),
                    ),
                  ),
                  // Center/right: event banner area
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: FairFColors.surface.withOpacity(0.55),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: FairFColors.cyan.withOpacity(0.3)),
                        ),
                        child: const Center(
                          child: Text(
                            'Event banner goes here',
                            style: TextStyle(color: FairFColors.textSecondary, fontSize: 16),
                          ),
                        ),
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

class _NavButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _NavButton({required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: FairFColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: FairFColors.yellow.withOpacity(0.4)),
        ),
        child: Column(
          children: [
            Icon(icon, color: FairFColors.yellow, size: 26),
            const SizedBox(height: 6),
            Text(label, style: const TextStyle(color: FairFColors.textPrimary, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
