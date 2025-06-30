import 'package:flutter/material.dart';
import 'package:persona_data/lib.dart';
import 'package:catppuccin_flutter/catppuccin_flutter.dart';

class DetailedShadowPageAilmentsBox extends StatelessWidget {
  final Map<Ailment, Affinity> ailments;
  const DetailedShadowPageAilmentsBox({super.key, required this.ailments});

  @override
  Widget build(BuildContext context) {
    final tStyle = Theme.of(
      context,
    ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold);
    final flavor = catppuccin.mocha;

    Text affinityText(Ailment element) {
      switch (ailments[element]) {
        case Affinity.weak:
          return Text('Wk', style: tStyle.copyWith(color: flavor.red));
        case Affinity.resist:
          return Text('Rs', style: tStyle.copyWith(color: flavor.yellow));
        case Affinity.nullify:
          return Text('Nu', style: tStyle.copyWith(color: flavor.lavender));
        case Affinity.repel:
          return Text('Rp', style: tStyle.copyWith(color: flavor.sky));
        case Affinity.absorb:
          return Text('Dr', style: tStyle.copyWith(color: flavor.green));
        default:
          return Text('-', style: tStyle);
      }
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
            children: [
              affinityTableCell(Text('Cha', style: tStyle)),
              affinityTableCell(Text('Poi', style: tStyle)),
              affinityTableCell(Text('Dis', style: tStyle)),
              affinityTableCell(Text('Con', style: tStyle)),
              affinityTableCell(Text('Fea', style: tStyle)),
              affinityTableCell(Text('Rag', style: tStyle)),
            ],
          ),
          TableRow(
            children: [
              affinityTableCell(affinityText(Ailment.charm)),
              affinityTableCell(affinityText(Ailment.poison)),
              affinityTableCell(affinityText(Ailment.distress)),
              affinityTableCell(affinityText(Ailment.confusion)),
              affinityTableCell(affinityText(Ailment.fear)),
              affinityTableCell(affinityText(Ailment.rage)),
            ],
          ),
        ],
      ),
    );
  }
}
