import 'package:flutter/material.dart';

class DetailedShadowPageSkillsList extends StatelessWidget {
  final List<String> skills;
  const DetailedShadowPageSkillsList({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    final tStyle = Theme.of(context).textTheme.bodyLarge!;

    TableRow skillRow(String skill) {
      return TableRow(
        children: [
          Container(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 16.0, vertical: 8.0),
            color: Theme.of(context).listTileTheme.tileColor!.withAlpha(100),
            child: Text(skill, style: tStyle),
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
        children: [...skills.map(skillRow)],
      ),
    );
  }
}
