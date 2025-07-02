import 'package:flutter/material.dart';

class DetailedSkillLearntBox extends StatelessWidget {
  final Map<String, int> personas;

  const DetailedSkillLearntBox({super.key, required this.personas});

  @override
  Widget build(BuildContext context) {
    final tStyle = Theme.of(context).textTheme.bodyLarge!;

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
      return TableRow(
        children: [
          Container(
            padding: EdgeInsetsGeometry.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
            color: Theme.of(context).listTileTheme.tileColor!.withAlpha(100),
            child: Text(personaName, style: tStyle),
          ),
          Container(
            padding: EdgeInsetsGeometry.all(8.0),
            color: Theme.of(context).listTileTheme.tileColor!.withAlpha(100),
            child: Center(
              child: Text(level > 0 ? level.toString() : '-', style: tStyle),
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
        ...sorted.where((entry) => entry.value < 100).map(skillRow),
      ],
    );
  }
}
