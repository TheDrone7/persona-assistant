import 'dart:ui';

import 'package:flutter/material.dart';

class NavigationDrawerItem extends StatelessWidget {
  final bool selected;
  final VoidCallback onTap;
  final Widget icon;
  final Widget selectedIcon;
  final String label;

  const NavigationDrawerItem({
    super.key,
    required this.selected,
    required this.onTap,
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: selected
                      ? Theme.of(context).colorScheme.onSecondary
                      : Theme.of(context).colorScheme.outline,
                  width: selected ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(4),
                color: selected
                    ? Theme.of(context).colorScheme.secondary.withAlpha(250)
                    : Theme.of(context).colorScheme.primary.withAlpha(120),
              ),
              child: ListTile(
                leading: selected ? selectedIcon : icon,
                title: Text(
                  label,
                  style: TextStyle(
                    fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                selected: selected,
                selectedColor: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
