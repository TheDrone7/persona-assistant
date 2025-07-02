import 'package:flutter/material.dart';
import 'package:persona_data/lib.dart';

import 'detailed/page.dart';

class PersonaListItem extends StatelessWidget {
  const PersonaListItem({super.key, required this.persona});

  final Persona persona;

  @override
  Widget build(BuildContext context) {
    String iconPath = 'assets/p3r/${persona.arcana.imagePath}';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
      child: ListTile(
        leading: Image.asset(iconPath),
        title: Text(
          persona.name,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: Theme.of(context).colorScheme.onSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              persona.arcana == Arcana.hanged
                  ? 'Hanged Man'
                  : persona.arcana.toString(),
            ),
            SizedBox(height: 4.0),
            Text(
              persona.unlockMethod == PersonaUnlockMethod.level
                  ? 'Unlocked at level ${persona.level}'
                  : '${persona.conditionShort} Persona',
            ),
          ],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        tileColor: persona.unlockMethod == PersonaUnlockMethod.locked
            ? Theme.of(context).colorScheme.onError.withAlpha(40)
            : null,
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailedPersonaPage(persona: persona),
          ),
        ),
      ),
    );
  }
}
