import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import '../theme/colors.dart';

enum _LeftTab { characters, guns }

class CharacterModel {
  final String id;
  final String displayName;
  final String thumbnailPath;
  final String glbPath;

  const CharacterModel({
    required this.id,
    required this.displayName,
    required this.thumbnailPath,
    required this.glbPath,
  });
}

const _testCharacters = [
  CharacterModel(
    id: 'character-male-a',
    displayName: 'Free',
    thumbnailPath: 'assets/characters/character-male-a.png',
    glbPath: 'assets/characters_3d/character-male-a.glb',
  ),
  CharacterModel(
    id: 'character-male-b',
    displayName: 'Bold',
    thumbnailPath: 'assets/characters/character-male-b.png',
    glbPath: 'assets/characters_3d/character-male-b.glb',
  ),
  CharacterModel(
    id: 'character-male-c',
    displayName: 'Officer',
    thumbnailPath: 'assets/characters/character-male-c.png',
    glbPath: 'assets/characters_3d/character-male-c.glb',
  ),
  CharacterModel(
    id: 'character-female-a',
    displayName: 'Fair',
    thumbnailPath: 'assets/characters/character-female-a.png',
    glbPath: 'assets/characters_3d/character-female-a.glb',
  ),
  CharacterModel(
    id: 'character-female-b',
    displayName: 'Fun',
    thumbnailPath: 'assets/characters/character-female-b.png',
    glbPath: 'assets/characters_3d/character-female-b.glb',
  ),
];

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({super.key});

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  _LeftTab _tab = _LeftTab.characters;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final selected = _testCharacters[_selectedIndex];

    return Scaffold(
      backgroundColor: FairFColors.background,
      body: SafeArea(
        child: Row(
          children: [
            // Left rail: Characters / Guns
            SizedBox(
              width: 90,
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  _SideTabButton(
                    icon: Icons.person_rounded,
                    label: 'Characters',
                    selected: _tab == _LeftTab.characters,
                    onTap: () => setState(() => _tab = _LeftTab.characters),
                  ),
                  const SizedBox(height: 12),
                  _SideTabButton(
                    icon: Icons.gps_fixed_rounded,
                    label: 'Guns',
                    selected: _tab == _LeftTab.guns,
                    onTap: () => setState(() => _tab = _LeftTab.guns),
                  ),
                ],
              ),
            ),

            // Main content
            Expanded(
              child: _tab == _LeftTab.characters
                  ? _CharactersView(
                      selected: selected,
                      selectedIndex: _selectedIndex,
                      onSelect: (i) => setState(() => _selectedIndex = i),
                    )
                  : const Center(
                      child: Text(
                        'Guns — coming soon',
                        style: TextStyle(color: FairFColors.textSecondary, fontSize: 18),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CharactersView extends StatelessWidget {
  final CharacterModel selected;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  const _CharactersView({
    required this.selected,
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Interactive 3D viewer — drag to rotate, matches the customize-screen feel
        Expanded(
          child: ModelViewer(
            key: ValueKey(selected.id),
            backgroundColor: Colors.transparent,
            src: selected.glbPath,
            alt: selected.displayName,
            autoRotate: true,
            autoRotateDelay: 800,
            rotationPerSecond: '18deg',
            cameraControls: true,
            disableZoom: false,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(
            selected.displayName,
            style: const TextStyle(
              color: FairFColors.yellow,
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
        ),
        // Thumbnail strip to pick a character
        SizedBox(
          height: 92,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            itemCount: _testCharacters.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, i) {
              final c = _testCharacters[i];
              final isSelected = i == selectedIndex;
              return GestureDetector(
                onTap: () => onSelect(i),
                child: Container(
                  width: 76,
                  decoration: BoxDecoration(
                    color: FairFColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? FairFColors.cyan : Colors.white24,
                      width: isSelected ? 2.5 : 1,
                    ),
                  ),
                  padding: const EdgeInsets.all(4),
                  child: Image.asset(c.thumbnailPath, fit: BoxFit.contain),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SideTabButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _SideTabButton({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: 72,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        decoration: BoxDecoration(
          color: selected ? FairFColors.surface : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? FairFColors.yellow : Colors.white24,
            width: selected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: selected ? FairFColors.yellow : Colors.white70, size: 22),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: selected ? FairFColors.yellow : Colors.white70,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
