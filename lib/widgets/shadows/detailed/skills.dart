import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:p3r_data/lib.dart';

import 'package:persona_assistant/state/state.dart';
import '../../skills/detailed/page.dart';
import '../../common/detailed/shared.dart';

/// Displays a table of skills for a Shadow.
class DetailedShadowPageSkillsList extends StatelessWidget {
  /// List of skill names.
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
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Table(
            border: TableBorder.all(
              color: Theme.of(context).dividerColor.withAlpha(50),
            ),
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(1.0),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [...shadowSkills.map(skillRow)],
          ),
        ),
      ),
    );
  }
}
