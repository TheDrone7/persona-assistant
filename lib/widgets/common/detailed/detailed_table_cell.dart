import 'package:flutter/material.dart';
import 'dart:ui';

/// A reusable table cell widget for detailed views in persona and shadow pages.
///
/// Provides consistent padding, background color, alignment, and backdrop blur for table cells.
class DetailedTableCell extends StatelessWidget {
  /// The widget to display inside the cell.
  final Widget child;

  /// Optional padding for the cell. Defaults to EdgeInsets.all(8.0).
  final EdgeInsetsGeometry padding;

  /// Optional background color. If null, uses the theme's listTileTheme.tileColor with alpha.
  final Color? backgroundColor;

  /// Alignment for the child widget. Defaults to center.
  final AlignmentGeometry alignment;

  /// Blur sigma value for the backdrop filter. Defaults to 5.0.
  final double blurSigma;

  const DetailedTableCell({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(8.0),
    this.backgroundColor,
    this.alignment = Alignment.center,
    this.blurSigma = 5.0,
  });

  @override
  Widget build(BuildContext context) {
    final color =
        backgroundColor ??
        Theme.of(context).listTileTheme.tileColor?.withAlpha(150) ??
        Theme.of(context).colorScheme.surface.withAlpha(150);
    
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(color: color),
          alignment: alignment,
          child: child,
        ),
      ),
    );
  }
}
