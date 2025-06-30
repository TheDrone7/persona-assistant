import 'package:flutter/material.dart';
import 'package:persona_data/lib.dart';
import 'package:catppuccin_flutter/catppuccin_flutter.dart';

class DetailedShadowPageAffinitiesBox extends StatelessWidget {
  final Map<CombatElement, Affinity> affinities;
  const DetailedShadowPageAffinitiesBox({super.key, required this.affinities});

  @override
  Widget build(BuildContext context) {
    final tStyle = Theme.of(
      context,
    ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold);
    final flavor = catppuccin.mocha;

    Text affinityText(CombatElement element) {
      switch (affinities[element]) {
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
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(
            children: [
              affinityTableCell(
                Image.asset('assets/p3r/images/skills/slash.png'),
              ),
              affinityTableCell(
                Image.asset('assets/p3r/images/skills/strike.png'),
              ),
              affinityTableCell(
                Image.asset('assets/p3r/images/skills/pierce.png'),
              ),
              affinityTableCell(
                Image.asset('assets/p3r/images/skills/fire.png'),
              ),
              affinityTableCell(
                Image.asset('assets/p3r/images/skills/ice.png'),
              ),
            ],
          ),
          TableRow(
            children: [
              affinityTableCell(affinityText(CombatElement.slash)),
              affinityTableCell(affinityText(CombatElement.strike)),
              affinityTableCell(affinityText(CombatElement.pierce)),
              affinityTableCell(affinityText(CombatElement.fire)),
              affinityTableCell(affinityText(CombatElement.ice)),
            ],
          ),
          TableRow(
            children: [
              affinityTableCell(
                Image.asset('assets/p3r/images/skills/electric.png'),
              ),
              affinityTableCell(
                Image.asset('assets/p3r/images/skills/wind.png'),
              ),
              affinityTableCell(
                Image.asset('assets/p3r/images/skills/light.png'),
              ),
              affinityTableCell(
                Image.asset('assets/p3r/images/skills/dark.png'),
              ),
              affinityTableCell(
                Image.asset('assets/p3r/images/skills/almighty.png'),
              ),
            ],
          ),
          TableRow(
            children: [
              affinityTableCell(affinityText(CombatElement.electric)),
              affinityTableCell(affinityText(CombatElement.wind)),
              affinityTableCell(affinityText(CombatElement.light)),
              affinityTableCell(affinityText(CombatElement.dark)),
              affinityTableCell(affinityText(CombatElement.almighty)),
            ],
          ),
        ],
      ),
    );
  }
}
