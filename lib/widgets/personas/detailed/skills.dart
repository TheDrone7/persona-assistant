import 'package:flutter/material.dart';
import 'package:persona_assistant/state/state.dart';
import 'package:persona_data/lib.dart';
import 'package:provider/provider.dart';
import 'package:persona_assistant/widgets/skills/detailed/page.dart';
import 'package:persona_assistant/widgets/common/detailed_shared.dart';

/// Displays a table of skills for a Persona, including the level learned.
class DetailedPersonaPageSkillsList extends StatelessWidget {
  /// Map of skill names to the level they are learned.
  final Map<String, int> skills;
  const DetailedPersonaPageSkillsList({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    final tStyle = Theme.of(context).textTheme.bodyLarge!;
    final AppState state = Provider.of(context);
    final Map<PersonaSkill, int> personaSkills = skills.map((name, level) {
      final skill = state.personaData.skills.values.firstWhere(
        (skill) => skill.name == name,
      );
      return MapEntry(skill, level);
    });

    TableRow skillListHeader() {
      return TableRow(
        children: [
          DetailedTableCell(
            child: Center(
              child: Text(
                'Level',
                style: tStyle.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          DetailedTableCell(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Text(
              'Skill name',
              style: tStyle.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
    }

    TableRow skillRow(MapEntry<PersonaSkill, int> entry) {
      final skill = entry.key;
      final level = entry.value;
      return TableRow(
        children: [
          GestureDetector(
            onTap: () => showModalBottomSheet(
              context: context,
              builder: (context) => DetailedSkillPage(skill: skill),
            ),
            child: DetailedTableCell(
              child: Center(
                child: Text(level > 0 ? level.toString() : '-', style: tStyle),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => showModalBottomSheet(
              context: context,
              builder: (context) => DetailedSkillPage(skill: skill),
            ),
            child: DetailedTableCell(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              alignment: Alignment.centerLeft,
              child: Text(skill.name, style: tStyle),
            ),
          ),
        ],
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
      child: Table(
        border: TableBorder.all(
          color: Theme.of(context).dividerColor.withAlpha(50),
        ),
        columnWidths: const <int, TableColumnWidth>{
          0: FlexColumnWidth(1.0),
          1: FlexColumnWidth(4.0),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          skillListHeader(),
          ...personaSkills.entries
              .where((entry) => entry.value < 100)
              .map(skillRow),
        ],
      ),
    );
  }
}
