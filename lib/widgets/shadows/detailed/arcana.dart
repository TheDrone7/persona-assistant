import 'package:flutter/material.dart';
import 'package:persona_data/lib.dart';

class DetailedShadowPageArcanaBox extends StatelessWidget {
  final Arcana arcana;
  final String areaEncountered;
  final int level;
  final bool isBoss;

  const DetailedShadowPageArcanaBox({
    super.key,
    required this.arcana,
    required this.level,
    required this.areaEncountered,
    this.isBoss = false,
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
        'Level $level${isBoss ? ' Boss' : ''}',
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      horizontalTitleGap: 24.0,
      subtitle: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
        child: Text(
          '${arcana == Arcana.hanged ? 'Hanged Man' : arcana.toString()} • $areaEncountered',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
