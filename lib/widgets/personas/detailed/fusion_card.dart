import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persona_data/lib.dart';
import 'page.dart';

/// A card widget that displays a fusion or fission pair with their details.
///
/// This widget shows two personas side by side with an icon between them,
/// representing either a fusion (forward arrow) or fission (bidirectional arrow).
/// Each persona is clickable and navigates to its detailed page.
class FusionCard extends StatelessWidget {
  /// The first persona in the fusion/fission pair.
  final Persona persona1;

  /// The second persona in the fusion/fission pair.
  final Persona persona2;

  /// The formatted total estimated cost for the fusion/fission operation.
  final String totalPrice;

  /// The icon to display between the two personas.
  /// Typically [FontAwesomeIcons.arrowRightLong] for fusions or
  /// [FontAwesomeIcons.arrowRightArrowLeft] for fissions.
  final IconData icon;

  /// Creates a [FusionCard] widget.
  ///
  /// All parameters are required:
  /// - [persona1] and [persona2] represent the personas in the pair
  /// - [totalPrice] is the estimated cost for the operation
  /// - [icon] is the visual indicator between the personas
  const FusionCard({
    super.key,
    required this.persona1,
    required this.persona2,
    required this.totalPrice,
    required this.icon,
  });

  /// Builds a clickable persona card that navigates to the detailed page.
  ///
  /// [context] - The build context
  /// [persona] - The persona to display
  /// Returns a clickable card widget
  Widget _buildPersonaCard(BuildContext context, Persona persona) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: Material(
              color: Theme.of(context).colorScheme.surface.withAlpha(240),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: Theme.of(context).colorScheme.onPrimary.withAlpha(120),
                  width: 1.2,
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () {
                  try {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailedPersonaPage(persona: persona),
                      ),
                    );
                  } catch (e) {
                    // Handle navigation errors gracefully
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Unable to open ${persona.name} details'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 8,
                  ),
                  child: Column(
                    children: [
                      Text(
                        persona.name,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        persona.arcana.toString(),
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withAlpha(120),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.onSecondary.withAlpha(80),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            spreadRadius: 4,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Persona pair display
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildPersonaCard(context, persona1),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: FaIcon(icon),
                ),
                _buildPersonaCard(context, persona2),
              ],
            ),
            const SizedBox(height: 24),
            // Divider line
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 1.5,
                  color: Theme.of(context).colorScheme.outline.withAlpha(50),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Cost display
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Estimated cost: ',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  totalPrice,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
