import 'package:flutter/material.dart';
import 'package:persona_data/lib.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'arcana.dart';
import 'stats.dart';
import 'affinities.dart';
import 'ailments.dart';
import 'skills.dart';
import 'drops.dart';

class DetailedShadowPage extends StatelessWidget {
  final PersonaShadow shadow;
  const DetailedShadowPage({super.key, required this.shadow});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(shadow.name),
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.arrowLeft),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        children: [
          DetailedShadowPageArcanaBox(
            arcanaName: shadow.arcana,
            level: shadow.level,
            areaEncountered: shadow.areaEncountered,
            isBoss: shadow.isBoss,
          ),
          SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18.0,
              vertical: 4.0,
            ),
            child: Text(
              'Shadow Stats',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ),
          DetailedShadowPageStatsBox(
            stats: shadow.stats,
            hp: shadow.hp,
            mp: shadow.mp,
            xp: shadow.experience,
          ),
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
          DetailedShadowPageAffinitiesBox(affinities: shadow.affinities),
          SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18.0,
              vertical: 4.0,
            ),
            child: Text(
              'Ailment Affinities',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ),
          DetailedShadowPageAilmentsBox(ailments: shadow.ailments),
          ...(shadow.drops.isNotEmpty
              ? [
                  SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18.0,
                      vertical: 4.0,
                    ),
                    child: Text(
                      'Drops',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  ),
                  DetailedShadowPageDropsList(drops: shadow.drops),
                ]
              : []),
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
          DetailedShadowPageSkillsList(skills: shadow.skills),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
