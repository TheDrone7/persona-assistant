import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Model for a navigation destination in the app's drawer and navigation bar.
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

/// List of all navigation destinations in the app.
const List<NavDestination> destinations = [
  NavDestination(
    icon: FaIcon(FontAwesomeIcons.book),
    selectedIcon: FaIcon(FontAwesomeIcons.bookOpen),
    label: 'Persona List',
  ),
  NavDestination(
    icon: FaIcon(FontAwesomeIcons.bookMedical),
    selectedIcon: FaIcon(FontAwesomeIcons.bookOpen),
    label: 'Skills List',
  ),
  NavDestination(
    icon: FaIcon(FontAwesomeIcons.bookSkull),
    selectedIcon: FaIcon(FontAwesomeIcons.bookOpen),
    label: 'Shadow List',
  ),
  NavDestination(
    icon: FaIcon(FontAwesomeIcons.bookBookmark),
    selectedIcon: FaIcon(FontAwesomeIcons.bookOpen),
    label: 'Recipe Generator',
  ),
];
