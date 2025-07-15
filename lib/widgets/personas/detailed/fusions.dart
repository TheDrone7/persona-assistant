import 'package:flutter/material.dart';
import 'package:persona_data/lib.dart';
import 'package:persona_assistant/state/state.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'fusion_card.dart';

/// A tab widget that displays available fusion results for a given persona.
///
/// Fusions show which persona can be created by combining the current persona
/// with other available personas. This provides players with information about
/// potential fusion outcomes.
class FusionsTab extends StatelessWidget {
  /// The persona for which to display fusion options.
  final Persona persona;

  /// Creates a [FusionsTab] widget.
  ///
  /// The [persona] parameter is required and represents the source persona
  /// for which fusion results will be calculated.
  const FusionsTab({super.key, required this.persona});

  @override
  Widget build(BuildContext context) {
    final fusionCalc = Provider.of<AppState>(
      context,
    ).personaData.fusionCalculator;
    final fusions = fusionCalc.getFusionResults(persona);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Text(
            'Available Fusions',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
        ),
        // Fusion results list
        Expanded(
          child: ListView.builder(
            itemCount: fusions.length,
            itemBuilder: (context, index) {
              final fusion = fusions[index];
              final other = fusion.ingredients[0];
              final result = fusion.result;

              return FusionCard(
                persona1: other,
                persona2: result,
                totalPrice: fusion.formattedCost,
                icon: FontAwesomeIcons.arrowRightLong,
              );
            },
          ),
        ),
      ],
    );
  }
}
