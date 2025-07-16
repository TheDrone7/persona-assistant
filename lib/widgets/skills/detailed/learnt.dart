import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:persona_assistant/state/state.dart';
import '../../personas/detailed/page.dart';

class DetailedSkillLearntBox extends StatelessWidget {
  final Map<String, int> personas;

  const DetailedSkillLearntBox({super.key, required this.personas});

  @override
  Widget build(BuildContext context) {
    final tStyle = Theme.of(context).textTheme.bodyLarge!;
    final AppState state = Provider.of(context);

    TableRow skillListHeader() {
      return TableRow(
        children: [
          Container(
            padding: EdgeInsetsGeometry.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
            color: Theme.of(context).listTileTheme.tileColor!.withAlpha(100),
            child: Text(
              'Learnt by',
              style: tStyle.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ),
          Container(
            padding: EdgeInsetsGeometry.all(8.0),
            color: Theme.of(context).listTileTheme.tileColor!.withAlpha(100),
            child: Center(
              child: Text(
                'Level',
                style: tStyle.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      );
    }

    TableRow skillRow(MapEntry<String, int> entry) {
      final personaName = entry.key;
      final level = entry.value;

      final personaData = state.personaData.personas[personaName]!;

      return TableRow(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DetailedPersonaPage(persona: personaData),
              ),
            ),
            child: Container(
              padding: EdgeInsetsGeometry.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              color: Theme.of(context).listTileTheme.tileColor!.withAlpha(100),
              child: Text(personaName, style: tStyle),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DetailedPersonaPage(persona: personaData),
              ),
            ),
            child: Container(
              padding: EdgeInsetsGeometry.all(8.0),
              color: Theme.of(context).listTileTheme.tileColor!.withAlpha(100),
              child: Center(
                child: Text(level > 0 ? level.toString() : '-', style: tStyle),
              ),
            ),
          ),
        ],
      );
    }

    final sorted = personas.entries.toList();
    sorted.sort((a, b) => a.value.compareTo(b.value));

    return Table(
      border: TableBorder.all(
        color: Theme.of(context).dividerColor.withAlpha(50),
      ),
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(4.0),
        1: FlexColumnWidth(1.0),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        skillListHeader(),
        ...sorted
            .where(
              (entry) =>
                  entry.value < 100 &&
                  state.personaData.personas.containsKey(entry.key),
            )
            .map(skillRow),
      ],
    );
  }
}
