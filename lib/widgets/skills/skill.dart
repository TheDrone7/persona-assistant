import 'package:flutter/material.dart';
import 'package:persona_data/lib.dart';

import 'package:persona_assistant/types/extensions.dart';
import 'package:persona_assistant/widgets/common/styled_list_item.dart';
import 'detailed/page.dart';

class SkillListItem extends StatelessWidget {
  const SkillListItem({super.key, required this.skill});

  final PersonaSkill skill;

  @override
  Widget build(BuildContext context) {
    String effect = '';
    if (skill.type == SkillType.attack && skill.power > 0) {
      effect = 'Deals ${skill.power} ${skill.element.name} damage.';
    }

    if (skill.effect != 'No extra effect.') {
      effect += (effect.isEmpty ? '' : ' ') + skill.effect;
    }

    effect = effect.capitalize();
    if (effect.startsWith('X')) {
      effect = effect.replaceFirst('X', 'x');
    }

    String iconPath = 'assets/p3r/${skill.imagePath}';

    return StyledListItem(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return DetailedSkillPage(skill: skill);
          },
        );
      },
      child: ListTile(
        leading: Image.asset(iconPath),
        title: Text(
          skill.name,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Theme.of(context).colorScheme.onSecondary,
              ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 4.0,
            horizontal: 0.0,
          ),
          child: Text(effect),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
