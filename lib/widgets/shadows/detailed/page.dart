import 'package:flutter/material.dart';
import 'package:persona_data/lib.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persona_assistant/widgets/common/section_header.dart';
import 'package:persona_assistant/widgets/common/section_spacing.dart';
import 'dart:ui';

import 'arcana.dart';
import 'stats.dart';
import 'affinities.dart';
import 'ailments.dart';
import 'skills.dart';
import 'drops.dart';

/// A detailed page displaying all information about a [PersonaShadow].
class DetailedShadowPage extends StatelessWidget {
  /// The shadow to display.
  final PersonaShadow shadow;
  const DetailedShadowPage({super.key, required this.shadow});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/bg1.jpg',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            flexibleSpace: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                child: Container(color: Colors.transparent),
              ),
            ),
            title: Text(shadow.name),
            leading: IconButton(
              icon: const FaIcon(FontAwesomeIcons.xmark),
              onPressed: () =>
                  Navigator.of(context).popUntil((Route r) => r.isFirst),
            ),
          ),
          body: ListView(
            children: [
              DetailedShadowPageArcanaBox(
                arcana: shadow.arcana,
                level: shadow.level,
                areaEncountered: shadow.areaEncountered,
                isBoss: shadow.isBoss,
              ),
              const SectionSpacing(),
              const SectionHeader(title: 'Shadow Stats'),
              DetailedShadowPageStatsBox(
                stats: shadow.stats,
                hp: shadow.hp,
                mp: shadow.mp,
                xp: shadow.experience,
              ),
              const SectionSpacing(),
              const SectionHeader(title: 'Combat Affinities'),
              DetailedShadowPageAffinitiesBox(affinities: shadow.affinities),
              const SectionSpacing(),
              const SectionHeader(title: 'Ailment Affinities'),
              DetailedShadowPageAilmentsBox(ailments: shadow.ailments),
              if (shadow.drops.isNotEmpty) ...[
                const SectionSpacing(),
                const SectionHeader(title: 'Drops'),
                DetailedShadowPageDropsList(drops: shadow.drops),
              ],
              const SectionSpacing(),
              const SectionHeader(title: 'Skills'),
              DetailedShadowPageSkillsList(skills: shadow.skills),
              const SectionSpacing(),
            ],
          ),
        ),
      ],
    );
  }
}
