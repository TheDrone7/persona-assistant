import 'package:flutter/material.dart';

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
