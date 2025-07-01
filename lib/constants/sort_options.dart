import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persona_assistant/types/filters.dart';

final List<SortOption> personaSortOptions = [
  SortOption(
    label: 'Arcana',
    value: 'arcana',
    icon: FaIcon(FontAwesomeIcons.arrowDownWideShort),
  ),
  SortOption(
    label: 'Level',
    value: 'level_asc',
    icon: FaIcon(FontAwesomeIcons.arrowDownShortWide),
  ),
  SortOption(
    label: 'Level',
    value: 'level_desc',
    icon: FaIcon(FontAwesomeIcons.arrowUpWideShort),
  ),
  SortOption(
    label: 'Name',
    value: 'name_asc',
    icon: FaIcon(FontAwesomeIcons.arrowDownShortWide),
  ),
  SortOption(
    label: 'Name',
    value: 'name_desc',
    icon: FaIcon(FontAwesomeIcons.arrowUpWideShort),
  ),
];

