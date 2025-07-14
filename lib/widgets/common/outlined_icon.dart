import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// A widget that displays an icon with an outlined effect using two stacked [FaIcon]s.
class OutlinedIcon extends StatelessWidget {
  /// The icon to display.
  final IconData icon;

  /// The size of the icon. Defaults to 26.
  final double size;

  /// Creates an [OutlinedIcon] with the given [icon] and optional [size].
  const OutlinedIcon({super.key, required this.icon, this.size = 26});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        FaIcon(
          icon,
          size: size,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        FaIcon(icon),
      ],
    );
  }
}
