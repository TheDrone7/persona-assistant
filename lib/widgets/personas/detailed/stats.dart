import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:persona_data/lib.dart';
import 'package:persona_assistant/widgets/common/detailed_shared.dart';

/// Displays a table of stats for a Persona, including estimated price.
class DetailedPersonaPageStatsBox extends StatelessWidget {
  /// Map of persona stats to their values.
  final Map<PersonaStats, int> stats;

  const DetailedPersonaPageStatsBox({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(
      locale: 'en_US',
      symbol: '\u00a5',
      decimalDigits: 0,
    );
    final price =
        2000 + pow(stats.values.toList().reduce((acc, val) => acc + val), 2);

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
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: Theme.of(context).listTileTheme.tileColor!.withAlpha(100),
              border: Border.all(
                color: Theme.of(context).dividerColor.withAlpha(50),
              ),
            ),
            child: Row(
              children: [
                Text('Estimated price:', style: tStyle),
                const SizedBox(width: 20.0),
                Text(' ${formatter.format(price)}', style: tStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
