import 'package:persona_data/lib.dart';
import '../types/extensions.dart';
import '../types/filters.dart';

/// Filter options for personas, including all Arcana types.
final List<FilterOption> personaFilterOptions = [
  FilterOption(label: 'All', value: 'all'),
  ...Arcana.values.map((a) => FilterOption(label: a.toString(), value: a.name)),
];

/// Filter options for skills, including all combat elements and skill types (except attack).
final List<FilterOption> skillFilterOptions = [
  FilterOption(label: 'All', value: 'all'),
  ...CombatElement.values.map(
    (e) =>
        FilterOption(label: e.name.capitalize(), value: e.name.toLowerCase()),
  ),
  ...SkillType.values
      .where((t) => t != SkillType.attack && t != SkillType.special)
      .map(
        (t) => FilterOption(
          label: t.name.capitalize(),
          value: t.name.toLowerCase(),
        ),
      ),
];

/// Filter options for shadows, including all dungeon types and special categories.
final List<FilterOption> shadowFilterOptions = [
  FilterOption(label: 'All', value: 'all'),
  FilterOption(label: 'Thebel', value: 'thebel'),
  FilterOption(label: 'Monorail', value: 'monorail'),
  FilterOption(label: 'Arqa', value: 'arqa'),
  FilterOption(label: 'Yabbashah', value: 'yabbashah'),
  FilterOption(label: 'Tziah', value: 'tziah'),
  FilterOption(label: 'Harabah', value: 'harabah'),
  FilterOption(label: 'Adamah', value: 'adamah'),
  FilterOption(label: 'Other', value: 'unknown'),
  FilterOption(label: 'Tutorial', value: 'tutorial'),
  FilterOption(label: 'Boss', value: 'boss'),
  FilterOption(label: 'Ultimate', value: 'ultimate'),
];
