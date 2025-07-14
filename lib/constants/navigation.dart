import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../types/navigation.dart';

/// List of all navigation destinations in the app.
///
/// Used for the app's drawer and navigation bar.
final List<NavDestination> destinations = [
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
