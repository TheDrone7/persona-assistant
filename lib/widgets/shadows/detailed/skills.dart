import 'package:flutter/material.dart';
import 'package:persona_data/lib.dart';
import 'package:persona_assistant/state/state.dart';
import 'package:provider/provider.dart';
import 'package:persona_assistant/widgets/skills/detailed/page.dart';

class DetailedShadowPageSkillsList extends StatelessWidget {
  final List<String> skills;
  const DetailedShadowPageSkillsList({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    final tStyle = Theme.of(context).textTheme.bodyLarge!;
    final AppState state = Provider.of(context);

    final List<PersonaSkill> shadowSkills = skills.map((name) {
      final skill = state.personaData.skills[name]!;
      return skill;
    }).toList();

    TableRow skillRow(PersonaSkill skill) {
      return TableRow(
        children: [
          GestureDetector(
            onTap: () => showModalBottomSheet(
              context: context,
              builder: (context) => DetailedSkillPage(skill: skill),
            ),
            child: Container(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              color: Theme.of(context).listTileTheme.tileColor!.withAlpha(100),
              child: Text(skill.name, style: tStyle),
            ),
          ),
        ],
      );
    }

    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16.0, vertical: 0),
      child: Table(
        border: TableBorder.all(
          color: Theme.of(context).dividerColor.withAlpha(50),
        ),
        columnWidths: const <int, TableColumnWidth>{0: FlexColumnWidth(1.0)},
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [...shadowSkills.map(skillRow)],
      ),
    );
  }
}
