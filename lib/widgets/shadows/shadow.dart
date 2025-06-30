import 'package:flutter/material.dart';
import 'package:persona_data/lib.dart';

import 'detailed/page.dart';

class ShadowListItem extends StatelessWidget {
  const ShadowListItem({super.key, required this.shadow});

  final PersonaShadow shadow;

  @override
  Widget build(BuildContext context) {
    String iconPath = 'assets/p3r/images/arcana/${shadow.arcanaIcon}';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
      child: ListTile(
        leading: Image.asset(iconPath),
        title: Text(
          shadow.name,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: Theme.of(context).colorScheme.onSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          'Lvl ${shadow.level} • ${shadow.arcana == 'Hanged' ? 'Hanged Man' : shadow.arcana} at ${shadow.areaEncountered}',
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        tileColor: shadow.isBoss
            ? Theme.of(context).colorScheme.onError.withAlpha(40)
            : shadow.areaEncountered.toLowerCase().contains('tutorial')
            ? Theme.of(context).colorScheme.primary.withAlpha(80)
            : null,
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailedShadowPage(shadow: shadow),
          ),
        ),
      ),
    );
  }
}
