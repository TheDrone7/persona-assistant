import 'dart:ui';
import 'package:flutter/material.dart';

/// A widget representing a single item in the navigation drawer, with selection and icon support.
class NavigationDrawerItem extends StatelessWidget {
  /// Whether this item is currently selected.
  final bool selected;

  /// Callback when the item is tapped.
  final VoidCallback onTap;

  /// The icon to display when not selected.
  final Widget icon;

  /// The icon to display when selected.
  final Widget selectedIcon;

  /// The label for the item.
  final String label;

  /// Creates a [NavigationDrawerItem] with selection, icons, and label.
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
