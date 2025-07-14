import 'package:flutter/material.dart';
import 'package:persona_data/lib.dart';

import 'package:persona_assistant/types/extensions.dart';
import 'package:persona_assistant/widgets/common/styled_list_item.dart';
import 'detailed/page.dart';

/// A list item widget for displaying a Skill in the skills list.
class SkillListItem extends StatelessWidget {
  /// The skill to display.
  final PersonaSkill skill;

  /// Creates a [SkillListItem] for the given [skill].
  const SkillListItem({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    final String iconPath = 'assets/p3r/${skill.imagePath}';

    String buildSubtitle() {
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
      return effect;
    }

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
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
          child: Text(buildSubtitle()),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
