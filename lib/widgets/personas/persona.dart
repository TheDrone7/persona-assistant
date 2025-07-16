import 'package:flutter/material.dart';
import 'package:persona_data/lib.dart';

import '../common/styled_list_item.dart';
import 'detailed/page.dart';

/// A list item widget for displaying a Persona in the persona list.
class PersonaListItem extends StatelessWidget {
  /// The persona to display.
  final Persona persona;

  /// Creates a [PersonaListItem] for the given [persona].
  const PersonaListItem({super.key, required this.persona});

  @override
  Widget build(BuildContext context) {
    final String iconPath = 'assets/p3r/${persona.arcana.imagePath}';
    final Color? borderColor =
        persona.unlockMethod == PersonaUnlockMethod.locked
        ? Theme.of(context).colorScheme.onError.withAlpha(180)
        : persona.hasSpecialFusion
        ? Theme.of(context).colorScheme.onTertiary.withAlpha(180)
        : null;

    Widget buildSubtitle() {
      final arcanaLabel = persona.arcana == Arcana.hanged
          ? 'Hanged Man'
          : persona.arcana.toString();
      final unlockText = persona.unlockMethod == PersonaUnlockMethod.level
          ? 'Unlocked at level ${persona.level}'
          : '${persona.conditionShort} Persona';
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(arcanaLabel),
          const SizedBox(height: 4.0),
          Text(unlockText),
        ],
      );
    }

    return StyledListItem(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DetailedPersonaPage(persona: persona),
        ),
      ),
      borderColor: borderColor,
      child: ListTile(
        leading: Image.asset(iconPath),
        title: Text(
          persona.name,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: Theme.of(context).colorScheme.onSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: buildSubtitle(),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
