import 'package:flutter/material.dart';
import 'package:persona_data/lib.dart';
import 'package:persona_assistant/widgets/common/detailed_shared.dart';

/// Displays the arcana box for a Persona, including arcana, level, and special fusion info.
class DetailedPersonaPageArcanaBox extends StatelessWidget {
  /// The arcana to display.
  final Arcana arcana;

  /// The persona's level.
  final int level;

  /// Whether this persona has a special fusion.
  final bool isSpecial;

  const DetailedPersonaPageArcanaBox({
    super.key,
    required this.arcana,
    required this.level,
    required this.isSpecial,
  });

  @override
  Widget build(BuildContext context) {
    return DetailedArcanaBox(
      arcana: arcana,
      title: arcana == Arcana.hanged ? 'Hanged Man' : arcana.toString(),
      subtitle: 'Level $level${isSpecial ? ' (Special Fusion)' : ''}',
    );
  }
}
