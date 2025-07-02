import 'package:flutter/material.dart';
import 'package:persona_data/lib.dart';
import 'package:catppuccin_flutter/catppuccin_flutter.dart';

class DetailedShadowPageAffinitiesBox extends StatelessWidget {
  final Map<CombatElement, ResistanceCode> affinities;
  const DetailedShadowPageAffinitiesBox({super.key, required this.affinities});

  @override
  Widget build(BuildContext context) {
    final tStyle = Theme.of(
      context,
    ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold);
    final flavor = catppuccin.mocha;

    Text affinityText(CombatElement element) {
      switch (affinities[element]!.short) {
        case 'Wk':
          return Text('Wk', style: tStyle.copyWith(color: flavor.red));
        case 'Rs':
          return Text('Rs', style: tStyle.copyWith(color: flavor.yellow));
        case 'Nu':
          return Text('Nu', style: tStyle.copyWith(color: flavor.lavender));
        case 'Rp':
          return Text('Rp', style: tStyle.copyWith(color: flavor.sky));
        case 'Dr':
          return Text('Dr', style: tStyle.copyWith(color: flavor.green));
        default:
          return Text('-', style: tStyle);
      }
    }

    Text affinityDamage(CombatElement element) {
      return Text(
        affinities[element]!.damageValue > 0
            ? '${affinities[element]!.damageValue}%'
            : '-',
        style: tStyle.copyWith(fontWeight: FontWeight.normal),
      );
    }

    Container affinityTableCell(Widget child) {
      return Container(
        padding: EdgeInsetsGeometry.all(8.0),
        color: Theme.of(context).listTileTheme.tileColor!.withAlpha(100),
        child: Center(child: child),
      );
    }

    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16.0, vertical: 0),
      child: Table(
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
            children: CombatElement.values
                .sublist(0, 5)
                .map(
                  (e) => affinityTableCell(
                    Image.asset('assets/p3r/${e.imagePath}'),
                  ),
                )
                .toList(),
          ),
          TableRow(
            children: CombatElement.values
                .sublist(0, 5)
                .map((e) => affinityTableCell(affinityText(e)))
                .toList(),
          ),
          TableRow(
            children: CombatElement.values
                .sublist(0, 5)
                .map((e) => affinityTableCell(affinityDamage(e)))
                .toList(),
          ),
          TableRow(
            children: CombatElement.values
                .sublist(5)
                .map(
                  (e) => affinityTableCell(
                    Image.asset('assets/p3r/${e.imagePath}'),
                  ),
                )
                .toList(),
          ),
          TableRow(
            children: CombatElement.values
                .sublist(5)
                .map((e) => affinityTableCell(affinityText(e)))
                .toList(),
          ),
          TableRow(
            children: CombatElement.values
                .sublist(5)
                .map((e) => affinityTableCell(affinityDamage(e)))
                .toList(),
          ),
        ],
      ),
    );
  }
}
