import 'package:flutter/material.dart';
import 'package:persona_data/lib.dart';

import 'package:persona_assistant/types/padding.dart';
import '../../common/section_header.dart';
import '../../common/section_spacing.dart';

import 'affinities.dart';
import 'arcana.dart';
import 'inherits.dart';
import 'skills.dart';
import 'stats.dart';
import 'unlock.dart';

class InfoTab extends StatelessWidget {
  final Persona persona;
  const InfoTab({super.key, required this.persona});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DetailedPersonaPageArcanaBox(
          arcana: persona.arcana,
          level: persona.level,
          isSpecial: persona.hasSpecialFusion,
        ),
        if (persona.unlockMethod != PersonaUnlockMethod.level) ...[
          const SectionSpacing(),
          const SectionHeader(
            title: 'Requirements',
            padding: EdgeInsets.symmetric(
              horizontal: CommonPadding.horizontal,
              vertical: CommonPadding.requirementsVertical,
            ),
          ),
          DetailedPersonaUnlockMethodBox(
            details: persona.unlockMethod == PersonaUnlockMethod.locked
                ? "A party member's unique persona."
                : persona.fusionCondition ?? '',
            short: persona.conditionShort,
          ),
        ],
        const SectionSpacing(),
        const SectionHeader(title: 'Persona Stats'),
        DetailedPersonaPageStatsBox(
          stats: persona.stats,
          formattedPrice: persona.formattedPrice,
        ),
        const SectionSpacing(),
        const SectionHeader(title: 'Combat Affinities'),
        DetailedPersonaPageAffinitiesBox(affinities: persona.resistances),
        const SectionSpacing(),
        const SectionHeader(title: 'Skills'),
        DetailedPersonaPageSkillsList(skills: persona.skills),
        const SectionSpacing(),
        const SectionHeader(title: 'Fusion Inheritance Types'),
        DetailedPersonaPageInheritanceBox(inherits: persona.inheritanceType),
        const SectionSpacing(),
      ],
    );
  }
}
