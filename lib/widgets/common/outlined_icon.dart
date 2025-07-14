import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OutlinedIcon extends StatelessWidget {
  final IconData icon;
  final double size;

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
