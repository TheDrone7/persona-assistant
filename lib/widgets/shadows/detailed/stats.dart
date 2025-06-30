import 'package:flutter/material.dart';
import 'package:persona_data/lib.dart';

class DetailedShadowPageStatsBox extends StatelessWidget {
  final Map<PersonaStats, int> stats;
  final int hp;
  final int mp;

  const DetailedShadowPageStatsBox({
    super.key,
    required this.stats,
    required this.hp,
    required this.mp,
  });

  @override
  Widget build(BuildContext context) {
    final tStyle = Theme.of(
      context,
    ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold);

    Container statTableCell(String text, {bool isBold = false}) {
      return Container(
        padding: EdgeInsetsGeometry.all(8.0),
        color: Theme.of(context).listTileTheme.tileColor!.withAlpha(100),
        child: Center(
          child: Text(
            text,
            style: tStyle.copyWith(
              color: isBold
                  ? Theme.of(context).colorScheme.onSecondary
                  : Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16.0, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Table(
            border: TableBorder.all(
              color: Theme.of(context).dividerColor.withAlpha(50),
            ),
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(),
              1: FlexColumnWidth(),
              2: FlexColumnWidth(),
              3: FlexColumnWidth(),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                children: [
                  statTableCell('HP', isBold: true),
                  statTableCell(hp.toString()),
                  statTableCell('MP', isBold: true),
                  statTableCell(mp.toString()),
                ],
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Table(
            border: TableBorder.all(
              color: Theme.of(context).dividerColor.withAlpha(50),
            ),
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(),
              1: FlexColumnWidth(),
              2: FlexColumnWidth(),
              3: FlexColumnWidth(),
              4: FlexColumnWidth(),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                children: [
                  statTableCell('Str', isBold: true),
                  statTableCell('Mag', isBold: true),
                  statTableCell('End', isBold: true),
                  statTableCell('Agi', isBold: true),
                  statTableCell('Lck', isBold: true),
                ],
              ),
              TableRow(
                children: [
                  statTableCell(
                    stats[PersonaStats.strength]?.toString() ?? '0',
                  ),
                  statTableCell(stats[PersonaStats.magic]?.toString() ?? '0'),
                  statTableCell(
                    stats[PersonaStats.endurance]?.toString() ?? '0',
                  ),
                  statTableCell(stats[PersonaStats.agility]?.toString() ?? '0'),
                  statTableCell(stats[PersonaStats.luck]?.toString() ?? '0'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
