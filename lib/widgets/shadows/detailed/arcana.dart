import 'package:flutter/material.dart';
import 'package:persona_data/lib.dart';

import '../../common/detailed/shared.dart';

/// Displays the arcana box for a Shadow, including arcana, level, area, and boss info.
class DetailedShadowPageArcanaBox extends StatelessWidget {
  /// The arcana to display.
  final Arcana arcana;

  /// The area where the shadow is encountered.
  final String areaEncountered;

  /// The shadow's level.
  final int level;

  /// Whether this shadow is a boss.
  final bool isBoss;

  const DetailedShadowPageArcanaBox({
    super.key,
    required this.arcana,
    required this.level,
    required this.areaEncountered,
    this.isBoss = false,
  });

  @override
  Widget build(BuildContext context) {
    return DetailedArcanaBox(
      arcana: arcana,
      title: 'Level $level${isBoss ? ' Boss' : ''}',
      subtitle:
          '${arcana == Arcana.hanged ? 'Hanged Man' : arcana.toString()} \u2022 $areaEncountered',
    );
  }
}
