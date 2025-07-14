import 'package:flutter/material.dart';

/// A custom card widget with rounded corners, border, and optional margin and padding.
///
/// This widget is used to wrap content in a styled container similar to Material's Card,
/// but with custom appearance.
class Card extends StatelessWidget {
  /// The content of the card.
  final Widget child;

  /// Optional margin around the card.
  final EdgeInsetsGeometry? margin;

  /// Optional padding inside the card.
  final EdgeInsetsGeometry? padding;

  /// Creates a [Card] with [child], and optional [margin] and [padding].
  const Card({super.key, required this.child, this.margin, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.0),
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface.withAlpha(50),
          width: 1.0,
        ),
        color: Theme.of(context).colorScheme.primary.withAlpha(120),
      ),
      child: child,
    );
  }
}
