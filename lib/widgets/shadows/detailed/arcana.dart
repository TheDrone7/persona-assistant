import 'package:flutter/material.dart';

class DetailedPersonaPageArcanaBox extends StatelessWidget {
  final String arcanaName;
  final int level;

  const DetailedPersonaPageArcanaBox({
    super.key,
    required this.arcanaName,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      titleAlignment: ListTileTitleAlignment.center,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 32.0,
      ),
      leading: Image.asset(
        'assets/p3r/images/arcana/${arcanaName.toLowerCase()}.png',
      ),
      title: Text(
        arcanaName == 'Hanged' ? 'Hanged Man' : arcanaName,
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      horizontalTitleGap: 24.0,
      subtitle: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
        child: Text(
          'Level $level',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
