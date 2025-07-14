import 'package:flutter/material.dart';
import 'package:persona_data/lib.dart';

/// A reusable table cell widget for detailed views in persona and shadow pages.
///
/// Provides consistent padding, background color, and alignment for table cells.
class DetailedTableCell extends StatelessWidget {
  /// The widget to display inside the cell.
  final Widget child;

  /// Optional padding for the cell. Defaults to EdgeInsets.all(8.0).
  final EdgeInsetsGeometry padding;

  /// Optional background color. If null, uses the theme's list tile color with alpha.
  final Color? backgroundColor;

  /// Alignment for the child widget. Defaults to center.
  final AlignmentGeometry alignment;

  const DetailedTableCell({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(8.0),
    this.backgroundColor,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    final color =
        backgroundColor ??
        Theme.of(context).listTileTheme.tileColor?.withAlpha(100) ??
        Theme.of(context).colorScheme.surface.withAlpha(100);
    return Container(
      padding: padding,
      color: color,
      alignment: alignment,
      child: child,
    );
  }
}

/// A reusable arcana box widget for detailed persona and shadow pages.
///
/// Displays arcana icon, title, and subtitle with customizable content.
class DetailedArcanaBox extends StatelessWidget {
  /// The arcana to display.
  final Arcana arcana;

  /// The main title (e.g., persona or shadow name, or level info).
  final String title;

  /// The subtitle (e.g., arcana name, area, or special info).
  final String subtitle;

  /// Optional image padding.
  final EdgeInsetsGeometry imagePadding;

  const DetailedArcanaBox({
    super.key,
    required this.arcana,
    required this.title,
    required this.subtitle,
    this.imagePadding = const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      titleAlignment: ListTileTitleAlignment.center,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 32.0,
      ),
      leading: Padding(
        padding: imagePadding,
        child: Image.asset('assets/p3r/${arcana.imagePath}'),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      horizontalTitleGap: 24.0,
      subtitle: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
        child: Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
