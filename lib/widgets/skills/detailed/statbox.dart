import 'package:flutter/material.dart';
import 'package:persona_data/types/skill.dart';

class DetailedSkillStatBox extends StatelessWidget {
  final PersonaSkill skill;

  const DetailedSkillStatBox({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    final divColor = Theme.of(context).colorScheme.onSurface.withAlpha(50);
    final numStyle = Theme.of(context).textTheme.headlineSmall!;
    final labelStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(
      color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
      fontWeight: FontWeight.bold,
    );

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.0),
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface.withAlpha(50),
          width: 1.0,
        ),
        color: Theme.of(context).colorScheme.primary.withAlpha(120),
      ),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(height: 8.0),
                      Text(
                        skill.power.toString(),
                        style: numStyle,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'Power',
                        style: labelStyle,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8.0),
                    ],
                  ),
                ),
                VerticalDivider(color: divColor),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(height: 8.0),
                      Text(
                        '${skill.accuracy}%',
                        style: numStyle,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'Accuracy',
                        style: labelStyle,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8.0),
                    ],
                  ),
                ),
                VerticalDivider(color: divColor),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(height: 8.0),
                      Text(
                        '${skill.critChance}%',
                        style: numStyle,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'Crit chance',
                        style: labelStyle,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(color: divColor, height: 1.0),
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(height: 8.0),
                      Text(
                        '${skill.costType == SkillCostType.sp
                            ? '${skill.cost} '
                            : skill.costType == SkillCostType.hp
                            ? '${skill.cost}% '
                            : ''}${skill.costType.name.toUpperCase()}',
                        style: numStyle,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'Cost',
                        style: labelStyle,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8.0),
                    ],
                  ),
                ),
                VerticalDivider(color: divColor),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(height: 8.0),
                      Text(
                        skill.rank.toString(),
                        style: numStyle,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'Rank',
                        style: labelStyle,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8.0),
                    ],
                  ),
                ),
                VerticalDivider(color: divColor),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(height: 8.0),
                      Text(
                        (skill.minHits == skill.maxHits)
                            ? skill.maxHits.toString()
                            : '${skill.minHits} - ${skill.maxHits}',
                        style: numStyle,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'Hit${skill.maxHits == 1 ? '' : 's'}',
                        style: labelStyle,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
