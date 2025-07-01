import 'package:flutter/material.dart';

class DetailedShadowPageDropsList extends StatelessWidget {
  final Map<String, int> drops;
  const DetailedShadowPageDropsList({super.key, required this.drops});

  @override
  Widget build(BuildContext context) {
    final tStyle = Theme.of(context).textTheme.bodyLarge!;

    TableRow dropListHeader() {
      return TableRow(
        children: [
          Container(
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            color: Theme.of(context).listTileTheme.tileColor!.withAlpha(100),
            child: Text(
              'Item name',
              style: tStyle.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsetsGeometry.all(8.0),
            color: Theme.of(context).listTileTheme.tileColor!.withAlpha(100),
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
          Container(
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            color: Theme.of(context).listTileTheme.tileColor!.withAlpha(100),
            child: Text(droppedItem, style: tStyle),
          ),
          Container(
            padding: EdgeInsetsGeometry.all(8.0),
            color: Theme.of(context).listTileTheme.tileColor!.withAlpha(100),
            child: Center(child: Text('$rate%', style: tStyle)),
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
        columnWidths: const <int, TableColumnWidth>{
          0: FlexColumnWidth(5.0),
          1: FlexColumnWidth(2.0),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          dropListHeader(),
          ...drops.entries.where((entry) => entry.value < 100).map(dropRow),
        ],
      ),
    );
  }
}
