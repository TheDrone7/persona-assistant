import 'package:flutter/material.dart';
import 'package:persona_data/lib.dart';
import 'package:catppuccin_flutter/catppuccin_flutter.dart';

class DetailedShadowPageAilmentsBox extends StatelessWidget {
  final Map<Ailment, ResistanceCode> ailments;
  const DetailedShadowPageAilmentsBox({super.key, required this.ailments});

  @override
  Widget build(BuildContext context) {
    final tStyle = Theme.of(
      context,
    ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold);
    final flavor = catppuccin.mocha;

    Text affinityText(Ailment ailment) {
      switch (ailments[ailment]!.short) {
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

    Text affinityDamage(Ailment ailment) {
      return Text(
        ailments[ailment]!.damageValue > 0
            ? '${ailments[ailment]!.damageValue}%'
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
          5: FlexColumnWidth(),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(
            children: Ailment.values
                .map(
                  (a) => affinityTableCell(Text(a.toString(), style: tStyle)),
                )
                .toList(),
          ),
          TableRow(
            children: Ailment.values
                .map((a) => affinityTableCell(affinityText(a)))
                .toList(),
          ),
          TableRow(
            children: Ailment.values
                .map((a) => affinityTableCell(affinityDamage(a)))
                .toList(),
          ),
        ],
      ),
    );
  }
}
