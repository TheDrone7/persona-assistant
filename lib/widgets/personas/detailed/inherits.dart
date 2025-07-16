import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persona_data/lib.dart';
import 'package:catppuccin_flutter/catppuccin_flutter.dart';
import '../../common/detailed/detailed_table_cell.dart';

class DetailedPersonaPageInheritanceBox extends StatelessWidget {
  final InheritanceTypes inherits;
  const DetailedPersonaPageInheritanceBox({super.key, required this.inherits});

  @override
  Widget build(BuildContext context) {
    final flavor = catppuccin.mocha;

    FaIcon iconToShow(bool canInherit) {
      if (canInherit) {
        return FaIcon(FontAwesomeIcons.check, color: flavor.green, size: 16);
      }
      return FaIcon(FontAwesomeIcons.minus, color: flavor.surface0, size: 16);
    }

    final inheritances = inherits.asMap;

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
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(
            children: InheritanceElement.values
                .sublist(0, 6)
                .map(
                  (e) => DetailedTableCell(
                    padding: EdgeInsets.all(4.0),
                    child: Image.asset('assets/p3r/${e.imagePath}'),
                  ),
                )
                .toList(),
          ),
          TableRow(
            children: InheritanceElement.values
                .sublist(0, 6)
                .map(
                  (e) => DetailedTableCell(
                    padding: EdgeInsets.all(4.0),
                    child: iconToShow(inheritances[e] ?? false),
                  ),
                )
                .toList(),
          ),
          TableRow(
            children: InheritanceElement.values
                .sublist(6)
                .map(
                  (e) => DetailedTableCell(
                    padding: EdgeInsets.all(4.0),
                    child: Image.asset('assets/p3r/${e.imagePath}'),
                  ),
                )
                .toList(),
          ),
          TableRow(
            children: InheritanceElement.values
                .sublist(6)
                .map(
                  (e) => DetailedTableCell(
                    padding: EdgeInsets.all(4.0),
                    child: iconToShow(inheritances[e] ?? false),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
