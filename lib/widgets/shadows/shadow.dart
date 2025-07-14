import 'package:flutter/material.dart';
import 'package:persona_data/lib.dart';

import '../common/styled_list_item.dart';
import 'detailed/page.dart';

/// Widget for displaying a single Shadow in a styled list item.
class ShadowListItem extends StatelessWidget {
  /// Creates a [ShadowListItem] widget.
  const ShadowListItem({super.key, required this.shadow});

  final PersonaShadow shadow;

  @override
  Widget build(BuildContext context) {
    final String iconPath = 'assets/p3r/${shadow.arcana.imagePath}';
    final Color? borderColor = shadow.isBoss
        ? Theme.of(context).colorScheme.onError.withAlpha(240)
        : shadow.areaEncountered.toLowerCase().contains('tutorial')
            ? Theme.of(context).colorScheme.onTertiary.withAlpha(180)
            : null;

    String buildSubtitle() {
      final arcanaLabel = shadow.arcana == Arcana.hanged ? 'Hanged Man' : shadow.arcana.toString();
      return 'Lvl ${shadow.level} 2 $arcanaLabel at ${shadow.areaEncountered}';
    }

    return StyledListItem(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DetailedShadowPage(shadow: shadow),
        ),
      ),
      borderColor: borderColor,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0,
        ),
        leading: Image.asset(iconPath),
        title: Text(
          shadow.name,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Theme.of(context).colorScheme.onSecondary,
                fontWeight: FontWeight.bold,
              ),
        ),
        subtitle: Text(buildSubtitle()),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
      ),
    );
  }
}
