import 'package:flutter/material.dart';

/// A button that stretches a small pixel-art pill sprite (from the Kenney-style
/// UI sheet) to fit its label, using Flutter's 9-slice image stretching so the
/// rounded/bordered edges stay crisp instead of smearing.
class PillButton extends StatelessWidget {
  final String assetPath;
  final String label;
  final VoidCallback onTap;
  final double width;
  final double height;

  const PillButton({
    super.key,
    required this.assetPath,
    required this.label,
    required this.onTap,
    this.width = 150,
    this.height = 52,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image(
              image: AssetImage(assetPath),
              fit: BoxFit.fill,
              centerSlice: const Rect.fromLTWH(48, 0, 32, 128),
              filterQuality: FilterQuality.none, // keep pixel-art crisp
            ),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 16,
                letterSpacing: 0.5,
                shadows: [Shadow(color: Colors.black54, blurRadius: 4, offset: Offset(0, 1))],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
