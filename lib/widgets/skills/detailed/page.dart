import 'package:flutter/material.dart';
import 'package:persona_data/lib.dart';

import 'typebox.dart';
import 'statbox.dart';
import 'targetbox.dart';
import 'effect.dart';

class DetailedSkillPage extends StatelessWidget {
  final PersonaSkill skill;
  const DetailedSkillPage({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailedSkillTypeBox(iconName: skill.icon, skillName: skill.name),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                DetailedSkillStatBox(skill: skill),
                SizedBox(height: 16.0),
                DetailedSkillTargetBox(target: skill.target),
                SizedBox(height: 16.0),
                DetailedSkillEffectBox(effectText: skill.effect),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
