import 'dart:ui';

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
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: persona.unlockMethod == PersonaUnlockMethod.locked
                ? Theme.of(context).colorScheme.onError.withAlpha(240)
                : persona.hasSpecialFusion
                ? Theme.of(context).colorScheme.onTertiary.withAlpha(240)
                : Theme.of(context).colorScheme.onSecondary.withAlpha(120),
            width: 1.0,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
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
                  const SizedBox(height: 4.0),
                  Text(
                    persona.unlockMethod == PersonaUnlockMethod.level
                        ? 'Unlocked at level ${persona.level}'
                        : '${persona.conditionShort} Persona',
                  ),
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailedPersonaPage(persona: persona),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
