import 'package:flutter/material.dart';
import 'package:p3r_data/lib.dart';

import '../../common/detailed/shared.dart';

/// Displays a table of stats for a Shadow, including HP, MP, and XP.
class DetailedShadowPageStatsBox extends StatelessWidget {
  /// Map of shadow stats to their values.
  final Map<PersonaStats, int> stats;

  /// HP value.
  final int hp;

  /// MP value.
  final int mp;

  /// XP value.
  final int xp;

  const DetailedShadowPageStatsBox({
    super.key,
    required this.stats,
    required this.hp,
    required this.mp,
    required this.xp,
  });

  @override
  Widget build(BuildContext context) {
    final tStyle = Theme.of(
      context,
    ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
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
              4: FlexColumnWidth(),
              5: FlexColumnWidth(),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                children: [
                  DetailedTableCell(child: Text('HP', style: tStyle)),
                  DetailedTableCell(child: Text(hp.toString(), style: tStyle)),
                  DetailedTableCell(child: Text('MP', style: tStyle)),
                  DetailedTableCell(child: Text(mp.toString(), style: tStyle)),
                  DetailedTableCell(child: Text('XP', style: tStyle)),
                  DetailedTableCell(child: Text(xp.toString(), style: tStyle)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8.0),
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
                  DetailedTableCell(child: Text('Str', style: tStyle)),
                  DetailedTableCell(child: Text('Mag', style: tStyle)),
                  DetailedTableCell(child: Text('End', style: tStyle)),
                  DetailedTableCell(child: Text('Agi', style: tStyle)),
                  DetailedTableCell(child: Text('Lck', style: tStyle)),
                ],
              ),
              TableRow(
                children: [
                  DetailedTableCell(
                    child: Text(
                      stats[PersonaStats.strength]?.toString() ?? '0',
                      style: tStyle,
                    ),
                  ),
                  DetailedTableCell(
                    child: Text(
                      stats[PersonaStats.magic]?.toString() ?? '0',
                      style: tStyle,
                    ),
                  ),
                  DetailedTableCell(
                    child: Text(
                      stats[PersonaStats.endurance]?.toString() ?? '0',
                      style: tStyle,
                    ),
                  ),
                  DetailedTableCell(
                    child: Text(
                      stats[PersonaStats.agility]?.toString() ?? '0',
                      style: tStyle,
                    ),
                  ),
                  DetailedTableCell(
                    child: Text(
                      stats[PersonaStats.luck]?.toString() ?? '0',
                      style: tStyle,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
