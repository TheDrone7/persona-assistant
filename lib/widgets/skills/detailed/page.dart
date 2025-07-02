import 'package:flutter/material.dart';
import 'package:persona_data/lib.dart';

import 'typebox.dart';
import 'statbox.dart';
import 'targetbox.dart';
import 'effect.dart';
import 'card.dart';
import 'learnt.dart';

class DetailedSkillPage extends StatelessWidget {
  final PersonaSkill skill;
  const DetailedSkillPage({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DetailedSkillTypeBox(imagePath: skill.imagePath, skillName: skill.name),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              DetailedSkillStatBox(skill: skill),
              SizedBox(height: 16.0),
              DetailedSkillTargetBox(target: skill.target),
              SizedBox(height: 16.0),
              DetailedSkillEffectBox(effectText: skill.effect),
              if (skill.skillCard != null) ...[
                SizedBox(height: 16.0),
                DetailedSkillCardBox(skillCard: skill.skillCard!),
              ],
              SizedBox(height: 16.0),
              DetailedSkillLearntBox(personas: skill.personas),
            ],
          ),
        ),
      ],
    );
  }
}
