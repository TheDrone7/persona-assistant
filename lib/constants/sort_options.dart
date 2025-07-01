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

final List<SortOption> skillSortOptions = [
  SortOption(
    label: 'Default',
    value: 'default',
    icon: FaIcon(FontAwesomeIcons.arrowDownWideShort),
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
  SortOption(
    label: 'Cost',
    value: 'cost_asc',
    icon: FaIcon(FontAwesomeIcons.arrowDownShortWide),
  ),
  SortOption(
    label: 'Cost',
    value: 'cost_desc',
    icon: FaIcon(FontAwesomeIcons.arrowUpWideShort),
  ),
  SortOption(
    label: 'Rank',
    value: 'rank_asc',
    icon: FaIcon(FontAwesomeIcons.arrowDownShortWide),
  ),
  SortOption(
    label: 'Rank',
    value: 'rank_desc',
    icon: FaIcon(FontAwesomeIcons.arrowUpWideShort),
  ),
];
