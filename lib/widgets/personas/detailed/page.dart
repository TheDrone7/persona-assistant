import 'package:flutter/material.dart';
import 'package:persona_assistant/widgets/personas/detailed/unlock.dart';
import 'package:persona_data/lib.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persona_assistant/widgets/common/section_header.dart';
import 'package:persona_assistant/widgets/common/section_spacing.dart';
import 'package:persona_assistant/constants/detailed_page.dart';

import 'arcana.dart';
import 'stats.dart';
import 'affinities.dart';
import 'skills.dart';
import 'inherits.dart';

/// A detailed page displaying all information about a [Persona].
class DetailedPersonaPage extends StatelessWidget {
  /// The persona to display.
  final Persona persona;
  const DetailedPersonaPage({super.key, required this.persona});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(persona.name),
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.xmark),
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
          DetailedPersonaPageStatsBox(stats: persona.stats),
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
      ),
    );
  }
}
