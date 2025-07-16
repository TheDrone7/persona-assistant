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

/// A tab widget that displays available fusion results for a given persona.
///
/// Fusions show which persona can be created by combining the current persona
/// with other available personas. This provides players with information about
/// potential fusion outcomes.
class FusionsTab extends StatefulWidget {
  /// The persona for which to display fusion options.
  final Persona persona;

  /// Creates a [FusionsTab] widget.
  ///
  /// The [persona] parameter is required and represents the source persona
  /// for which fusion results will be calculated.
  const FusionsTab({super.key, required this.persona});

  @override
  State<FusionsTab> createState() => _FusionsTabState();
}

class _FusionsTabState extends State<FusionsTab> {
  SortOption _sortOrder = fusionSortOptions(1).first;

  void _setSortOrder(SortOption order) {
    setState(() {
      _sortOrder = order;
    });
  }

  @override
  Widget build(BuildContext context) {
    final fusionCalc = Provider.of<AppState>(
      context,
    ).personaData.fusionCalculator;
    final fusions = fusionCalc.getFusionResults(widget.persona);
    final sortedFusions = sortFusionResults(fusions, _sortOrder.value);

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
                    'Available Fusions (${sortedFusions.length})',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FusionSortButton(
                    ingredientCount: 1,
                    isFusion: true,
                    onSortChanged: _setSortOrder,
                  ),
                ],
              ),
            ),
          ),
        ),
        // Fusion results list
        Expanded(
          child: ListView.builder(
            itemCount: sortedFusions.length,
            itemBuilder: (context, index) {
              final fusion = sortedFusions[index];
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
