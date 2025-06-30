import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:persona_data/lib.dart';

class DetailedPersonaPageStatsBox extends StatelessWidget {
  final Map<PersonaStats, int> stats;

  const DetailedPersonaPageStatsBox({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(
      locale: 'en_US',
      symbol: '¥',
      decimalDigits: 0,
    );
    final price =
        2000 + pow(stats.values.toList().reduce((acc, val) => acc + val), 2);

    final tStyle = Theme.of(
      context,
    ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold);

    Container statTableCell(String text) {
      return Container(
        padding: EdgeInsetsGeometry.all(8.0),
        color: Theme.of(context).listTileTheme.tileColor!.withAlpha(100),
        child: Center(child: Text(text, style: tStyle)),
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
              4: FlexColumnWidth(),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                children: [
                  statTableCell('Str'),
                  statTableCell('Mag'),
                  statTableCell('End'),
                  statTableCell('Agi'),
                  statTableCell('Lck'),
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
          Container(
            padding: EdgeInsetsGeometry.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
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
