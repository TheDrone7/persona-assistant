import 'package:flutter/material.dart';
import 'package:persona_data/lib.dart';
import 'package:persona_assistant/state/state.dart';
import 'package:persona_assistant/constants/sort_options.dart';
import 'package:persona_assistant/utilities/fusion_sort.dart';
import 'package:persona_assistant/types/filters.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:ui';
import 'fusion_card.dart';
import '../../common/fusion_sort_button.dart';
import '../persona.dart';

/// A tab widget that displays available fission options for a given persona.
///
/// Fissions represent the reverse of fusion - they show which persona pairs
/// can be used to create the current persona. This tab is hidden for personas
/// that have special fusion requirements.
class FissionsTab extends StatefulWidget {
  /// The persona for which to display fission options.
  final Persona persona;

  /// Creates a [FissionsTab] widget.
  ///
  /// The [persona] parameter is required and represents the target persona
  /// for which fission options will be calculated.
  const FissionsTab({super.key, required this.persona});

  @override
  State<FissionsTab> createState() => _FissionsTabState();
}

class _FissionsTabState extends State<FissionsTab> {
  SortOption _sortOrder = fissionSortOptions(2).first;

  void _setSortOrder(SortOption order) {
    setState(() {
      _sortOrder = order;
    });
  }



  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final fusionCalc = appState.personaData.fusionCalculator;

    if (widget.persona.hasSpecialFusion) {
      final fission = fusionCalc.getSpecialFissions(widget.persona);
      
      if (fission == null) {
        return const SizedBox.shrink();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).appBarTheme.backgroundColor?.withAlpha(200) ?? 
                         Theme.of(context).colorScheme.surface.withAlpha(200),
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).colorScheme.outline.withAlpha(120),
                      width: 1,
                    ),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Special Recipe (${fission.ingredients.length})',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Estimated Cost: ${fission.formattedCost}',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: fission.ingredients.length,
              itemBuilder: (context, index) {
                final ingredient = fission.ingredients[index];
                return PersonaListItem(persona: ingredient);
              },
            ),
          ),
        ],
      );
    }

    final fissions = fusionCalc.getFissionOptions(widget.persona);
    final sortedFissions = sortFusionResults(fissions, _sortOrder.value);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).appBarTheme.backgroundColor?.withAlpha(200) ?? 
                       Theme.of(context).colorScheme.surface.withAlpha(200),
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).colorScheme.outline.withAlpha(120),
                    width: 1,
                  ),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Available Fissions (${sortedFissions.length})',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FusionSortButton(
                    ingredientCount: 2,
                    isFusion: false,
                    onSortChanged: _setSortOrder,
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: sortedFissions.length,
            itemBuilder: (context, index) {
              final fission = sortedFissions[index];
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
