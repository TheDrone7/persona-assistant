import 'package:flutter/material.dart';
import 'package:persona_assistant/widgets/personas/detailed/unlock.dart';
import 'package:persona_data/lib.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'arcana.dart';
import 'stats.dart';
import 'affinities.dart';
import 'skills.dart';
import 'inherits.dart';

class DetailedPersonaPage extends StatelessWidget {
  final Persona persona;
  const DetailedPersonaPage({super.key, required this.persona});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(persona.name),
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.xmark),
          onPressed: () =>
              Navigator.of(context).popUntil((Route r) => r.isFirst),
        ),
      ),
      body: ListView(
        children: [
          DetailedPersonaPageArcanaBox(
            arcana: persona.arcana,
            level: persona.level,
            isSpecial: persona.hasSpecialFusion,
          ),
          ...(persona.unlockMethod != PersonaUnlockMethod.level
              ? [
                  SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18.0,
                      vertical: 2.0,
                    ),
                    child: Text(
                      'Requirements',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  ),
                  DetailedPersonaUnlockMethodBox(
                    details: persona.unlockMethod == PersonaUnlockMethod.locked
                        ? 'A party member\'s unique persona.'
                        : persona.fusionCondition ?? '',
                    short: persona.conditionShort,
                  ),
                ]
              : []),
          SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18.0,
              vertical: 4.0,
            ),
            child: Text(
              'Persona Stats',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ),
          DetailedPersonaPageStatsBox(stats: persona.stats),
          SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18.0,
              vertical: 4.0,
            ),
            child: Text(
              'Combat Affinities',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ),
          DetailedPersonaPageAffinitiesBox(affinities: persona.resistances),
          SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18.0,
              vertical: 4.0,
            ),
            child: Text(
              'Skills',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ),
          DetailedPersonaPageSkillsList(skills: persona.skills),
          SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18.0,
              vertical: 4.0,
            ),
            child: Text(
              'Fusion Inheritance Types',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ),
          DetailedPersonaPageInheritanceBox(inherits: persona.inheritanceType),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
