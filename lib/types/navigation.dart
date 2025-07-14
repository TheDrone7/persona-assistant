import 'package:flutter/material.dart';

/// Model for a navigation destination in the app's drawer and navigation bar.
@immutable
class NavDestination {
  /// Creates a [NavDestination] with a label, icon, and selected icon.
  const NavDestination({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });

  /// The icon to display when not selected.
  final Widget icon;

  /// The icon to display when selected.
  final Widget selectedIcon;

  /// The label for the destination.
  final String label;
}
