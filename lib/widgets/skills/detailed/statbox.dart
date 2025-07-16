import 'package:flutter/material.dart';
import 'package:persona_data/lib.dart';

import '../../common/card.dart' as common;

class DetailedSkillStatBox extends StatelessWidget {
  final PersonaSkill skill;

  const DetailedSkillStatBox({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    final divColor = Theme.of(context).colorScheme.onSurface.withAlpha(50);

    String cost;
    switch (skill.costType) {
      case SkillCostType.hp:
        cost = '${skill.cost}% HP';
        break;
      case SkillCostType.sp:
        cost = '${skill.cost} SP';
        break;
      default:
        cost = skill.costType.name.toUpperCase();
    }

    return common.Card(
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                _Stat(label: 'Power', value: skill.power.toString()),
                VerticalDivider(color: divColor),
                _Stat(label: 'Accuracy', value: '${skill.accuracy}%'),
                VerticalDivider(color: divColor),
                _Stat(label: 'Crit chance', value: '${skill.critChance}%'),
              ],
            ),
          ),
          Divider(color: divColor, height: 1.0),
          IntrinsicHeight(
            child: Row(
              children: [
                _Stat(label: 'Cost', value: cost),
                VerticalDivider(color: divColor),
                _Stat(label: 'Rank', value: skill.rank.toString()),
                VerticalDivider(color: divColor),
                _Stat(
                  label: 'Hit${skill.maxHits == 1 ? '' : 's'}',
                  value: (skill.minHits == skill.maxHits)
                      ? skill.maxHits.toString()
                      : '${skill.minHits} - ${skill.maxHits}',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String label;
  final String value;

  const _Stat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final numStyle = Theme.of(context).textTheme.headlineSmall!;
    final labelStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(
      color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
      fontWeight: FontWeight.bold,
    );
    return Expanded(
      child: Column(
        children: [
          const SizedBox(height: 8.0),
          Text(value, style: numStyle, textAlign: TextAlign.center),
          const SizedBox(height: 4.0),
          Text(label, style: labelStyle, textAlign: TextAlign.center),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
