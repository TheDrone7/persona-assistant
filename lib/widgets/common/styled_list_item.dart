import 'dart:ui';

import 'package:flutter/material.dart';

class StyledListItem extends StatelessWidget {
  const StyledListItem({
    super.key,
    required this.child,
    required this.onTap,
    this.borderColor,
  });

  final Widget child;
  final VoidCallback onTap;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
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
