import 'package:flutter/material.dart';

class NavDestination {
  const NavDestination({
    required this.label,
    required this.icon,
    this.selectedIcon,
  });

  final Icon icon;
  final Icon? selectedIcon;
  final String label;
}

const List<NavDestination> destinations = [
  NavDestination(
    icon: Icon(Icons.format_list_bulleted_rounded),
    selectedIcon: Icon(Icons.view_list_rounded),
    label: 'Persona List',
  ),
  NavDestination(
    icon: Icon(Icons.electric_bolt_outlined),
    label: 'Skills List',
    selectedIcon: Icon(Icons.electric_bolt_rounded),
  ),
  NavDestination(
    icon: Icon(Icons.dangerous_outlined),
    selectedIcon: Icon(Icons.dangerous_rounded),
    label: 'Shadow List',
  ),
  NavDestination(icon: Icon(Icons.merge_rounded), label: 'Recipe Generator'),
];
