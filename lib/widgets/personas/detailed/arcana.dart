import 'package:flutter/material.dart';
import 'package:persona_data/lib.dart';

class DetailedPersonaPageArcanaBox extends StatelessWidget {
  final Arcana arcana;
  final int level;
  final bool isSpecial;

  const DetailedPersonaPageArcanaBox({
    super.key,
    required this.arcana,
    required this.level,
    required this.isSpecial,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      titleAlignment: ListTileTitleAlignment.center,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 32.0,
      ),
      leading: Image.asset('assets/p3r/${arcana.imagePath}'),
      title: Text(
        arcana == Arcana.hanged ? 'Hanged Man' : arcana.toString(),
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      horizontalTitleGap: 24.0,
      subtitle: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
        child: Text(
          'Level $level${isSpecial ? ' (Special Fusion)' : ''}',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
