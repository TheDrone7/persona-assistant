import 'package:flutter/material.dart';
import '../../common/detailed/shared.dart';

/// Displays a table of item drops for a Shadow.
class DetailedShadowPageDropsList extends StatelessWidget {
  /// Map of item names to drop rates.
  final Map<String, int> drops;
  const DetailedShadowPageDropsList({super.key, required this.drops});

  @override
  Widget build(BuildContext context) {
    final tStyle = Theme.of(context).textTheme.bodyLarge!;

    TableRow dropListHeader() {
      return TableRow(
        children: [
          DetailedTableCell(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            alignment: Alignment.centerLeft,
            child: Text(
              'Item name',
              style: tStyle.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          DetailedTableCell(
            child: Center(
              child: Text(
                'Drop rate',
                style: tStyle.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      );
    }

    TableRow dropRow(MapEntry<String, int> entry) {
      final droppedItem = entry.key;
      final rate = entry.value;
      return TableRow(
        children: [
          DetailedTableCell(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            alignment: Alignment.centerLeft,
            child: Text(droppedItem, style: tStyle),
          ),
          DetailedTableCell(
            child: Center(child: Text('$rate%', style: tStyle)),
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
          0: FlexColumnWidth(5.0),
          1: FlexColumnWidth(2.0),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [dropListHeader(), ...drops.entries.map(dropRow)],
      ),
    );
  }
}
