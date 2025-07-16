import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../types/filters.dart';

/// Sort options for personas, by arcana, level, or name.
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

/// Sort options for skills, by default, name, cost, or rank.
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

/// Sort options for shadows, by level, name, or arcana.
final List<SortOption> shadowSortOptions = [
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
  SortOption(
    label: 'Arcana',
    value: 'arcana',
    icon: FaIcon(FontAwesomeIcons.arrowDownWideShort),
  ),
];

/// Sort options for fissions, by cost, ingredient, and result.
List<SortOption> fissionSortOptions(int ingredients) {
  return [
    SortOption(
      label: 'Total Cost',
      value: 'total_asc',
      icon: FaIcon(FontAwesomeIcons.arrowDownShortWide),
    ),
    SortOption(
      label: 'Total Cost',
      value: 'total_desc',
      icon: FaIcon(FontAwesomeIcons.arrowUpWideShort),
    ),
    ...List.generate(
      ingredients,
      (index) => [
        SortOption(
          label: 'Persona ${index + 1} Arcana',
          value: '${index}_arcana',
          icon: FaIcon(FontAwesomeIcons.arrowDownWideShort),
        ),
        SortOption(
          label: 'Persona ${index + 1} Name',
          value: '${index}_name_asc',
          icon: FaIcon(FontAwesomeIcons.arrowDownShortWide),
        ),
        SortOption(
          label: 'Persona ${index + 1} Name',
          value: '${index}_name_desc',
          icon: FaIcon(FontAwesomeIcons.arrowUpWideShort),
        ),
        SortOption(
          label: 'Persona ${index + 1} Level',
          value: '${index}_level_asc',
          icon: FaIcon(FontAwesomeIcons.arrowDownShortWide),
        ),
        SortOption(
          label: 'Persona ${index + 1} Level',
          value: '${index}_level_desc',
          icon: FaIcon(FontAwesomeIcons.arrowUpWideShort),
        ),
      ],
    ).expand((options) => options),
  ];
}

/// Sort options for fusions, by cost, ingredient, and result.
List<SortOption> fusionSortOptions(int ingredients) {
  return fissionSortOptions(ingredients) +
      [
        SortOption(
          label: 'Result Arcana',
          value: 'result_arcana',
          icon: FaIcon(FontAwesomeIcons.arrowDownWideShort),
        ),
        SortOption(
          label: 'Result Name',
          value: 'result_name_asc',
          icon: FaIcon(FontAwesomeIcons.arrowDownShortWide),
        ),
        SortOption(
          label: 'Result Name',
          value: 'result_name_desc',
          icon: FaIcon(FontAwesomeIcons.arrowUpWideShort),
        ),
        SortOption(
          label: 'Result Level',
          value: 'result_level_asc',
          icon: FaIcon(FontAwesomeIcons.arrowDownShortWide),
        ),
        SortOption(
          label: 'Result Level',
          value: 'result_level_desc',
          icon: FaIcon(FontAwesomeIcons.arrowUpWideShort),
        ),
      ];
}
