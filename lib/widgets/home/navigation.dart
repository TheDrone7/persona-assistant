import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavDestination {
  const NavDestination({
    required this.label,
    required this.icon,
    this.selectedIcon,
  });

  final Widget icon;
  final Widget? selectedIcon;
  final String label;
}

const List<NavDestination> destinations = [
  NavDestination(icon: FaIcon(FontAwesomeIcons.book), label: 'Persona List'),
  NavDestination(
    icon: FaIcon(FontAwesomeIcons.bookMedical),
    label: 'Skills List',
  ),
  NavDestination(
    icon: FaIcon(FontAwesomeIcons.bookSkull),
    label: 'Shadow List',
  ),
  NavDestination(
    icon: FaIcon(FontAwesomeIcons.bookBookmark),
    label: 'Recipe Generator',
  ),
];
