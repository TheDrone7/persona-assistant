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
