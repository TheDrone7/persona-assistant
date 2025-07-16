import 'dart:ui';
import 'package:flutter/material.dart';

/// A list item widget with a blurred background and a styled border, supporting tap interaction.
///
/// This widget is useful for visually distinct list items with a glassmorphic effect.
class StyledListItem extends StatelessWidget {
  /// Creates a [StyledListItem] with a blurred background and border.
  ///
  /// [child] is the content of the list item.
  /// [onTap] is the callback when the item is tapped.
  /// [borderColor] optionally overrides the default border color.
  const StyledListItem({
    super.key,
    required this.child,
    required this.onTap,
    this.borderColor,
  });

  /// The content of the list item.
  final Widget child;

  /// Callback when the item is tapped.
  final VoidCallback onTap;

  /// Optional border color for the item.
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: child,
            ),
          ),
          Positioned.fill(
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color:
                        borderColor ??
                        Theme.of(
                          context,
                        ).colorScheme.onSecondary.withAlpha(120),
                    width: 1.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
