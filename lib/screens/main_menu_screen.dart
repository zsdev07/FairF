import 'package:flutter/material.dart';
import '../theme/colors.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FairFColors.background,
      body: SafeArea(
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
                    color: FairFColors.surface,
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
