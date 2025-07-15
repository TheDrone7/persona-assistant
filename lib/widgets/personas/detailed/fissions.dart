import 'package:flutter/material.dart';
import 'package:persona_data/lib.dart';
import 'package:persona_assistant/state/state.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'fusion_card.dart';

/// A tab widget that displays available fission options for a given persona.
///
/// Fissions represent the reverse of fusion - they show which persona pairs
/// can be used to create the current persona. This tab is hidden for personas
/// that have special fusion requirements.
class FissionsTab extends StatelessWidget {
  /// The persona for which to display fission options.
  final Persona persona;

  /// Creates a [FissionsTab] widget.
  ///
  /// The [persona] parameter is required and represents the target persona
  /// for which fission options will be calculated.
  const FissionsTab({super.key, required this.persona});

  @override
  Widget build(BuildContext context) {
    if (persona.hasSpecialFusion) {
      return const SizedBox.shrink();
    }

    final fusionCalc = Provider.of<AppState>(
      context,
    ).personaData.fusionCalculator;
    final fissions = fusionCalc.getFissionOptions(persona);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Text(
            'Available Fissions',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
        ),
        // Fission options list
        Expanded(
          child: ListView.builder(
            itemCount: fissions.length,
            itemBuilder: (context, index) {
              final fission = fissions[index];
              final persona1 = fission.ingredients[0];
              final persona2 = fission.ingredients[1];

              return FusionCard(
                persona1: persona1,
                persona2: persona2,
                totalPrice: fission.formattedCost,
                icon: FontAwesomeIcons.arrowRightArrowLeft,
              );
            },
          ),
        ),
      ],
    );
  }
}
