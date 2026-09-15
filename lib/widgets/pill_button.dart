import 'package:flutter/material.dart';

/// A button built from a small pixel-art pill sprite. Uses BoxFit.cover
/// inside a fixed-size ClipRRect rather than 9-slice stretching — simpler
/// and can't silently render as invisible/blank the way a bad centerSlice
/// region can.
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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Stack(
            fit: StackFit.expand, // forces children to fill this exact box
            alignment: Alignment.center,
            children: [
              Image(
                image: AssetImage(assetPath),
                fit: BoxFit.cover,
                filterQuality: FilterQuality.none, // keep pixel-art crisp
                errorBuilder: (context, error, stackTrace) {
                  // Loud fallback — if you see a plain gray pill instead of
                  // the sprite, double check the exact filename/case.
                  return Container(
                    color: Colors.grey.shade700,
                  );
                },
              ),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                  letterSpacing: 0.5,
                  shadows: [Shadow(color: Colors.black87, blurRadius: 4, offset: Offset(0, 1))],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
