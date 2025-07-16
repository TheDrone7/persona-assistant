import 'package:flutter/material.dart';
import 'package:p3r_data/lib.dart';

import '../../common/card.dart' as common;

class DetailedSkillTargetBox extends StatelessWidget {
  final SkillTarget target;

  const DetailedSkillTargetBox({super.key, required this.target});

  @override
  Widget build(BuildContext context) {
    String targetName;

    switch (target) {
      case SkillTarget.self:
        targetName = 'Self';
        break;
      case SkillTarget.allAllies:
        targetName = 'All allies';
        break;
      case SkillTarget.allFoes:
        targetName = 'All foes';
        break;
      case SkillTarget.party:
        targetName = 'Party';
        break;
      case SkillTarget.randomAlly:
        targetName = 'Random ally';
        break;
      case SkillTarget.singleAlly:
        targetName = '1 ally';
        break;
      case SkillTarget.singleFoe:
        targetName = '1 foe';
        break;
      case SkillTarget.universal:
        targetName = 'Universal (all allies and foes)';
        break;
    }

    return common.Card(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Row(
        children: [
          Text('Target: ', style: Theme.of(context).textTheme.bodyLarge!),
          Text(
            targetName,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSecondary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
