import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:p3r_data/lib.dart';
import 'package:catppuccin_flutter/catppuccin_flutter.dart';

import '../../common/detailed/shared.dart';

/// Displays a table of ailment affinities for a Shadow.
class DetailedShadowPageAilmentsBox extends StatelessWidget {
  /// Map of ailments to resistance codes.
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

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
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
                      (a) => DetailedTableCell(
                        child: Text(a.toString(), style: tStyle),
                      ),
                    )
                    .toList(),
              ),
              TableRow(
                children: Ailment.values
                    .map((a) => DetailedTableCell(child: affinityText(a)))
                    .toList(),
              ),
              TableRow(
                children: Ailment.values
                    .map((a) => DetailedTableCell(child: affinityDamage(a)))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
