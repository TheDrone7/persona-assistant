import 'package:persona_assistant/types/extensions.dart';
import 'package:persona_assistant/types/filters.dart';
import 'package:persona_data/lib.dart';

final List<FilterOption> personaFilterOptions = [
  FilterOption(label: 'All', value: 'all'),
  ...PersonaData().arcana.map(
    (a) => FilterOption(label: a.capitalize(), value: a.toLowerCase()),
  ),
];

final List<FilterOption> skillFilterOptions = [
  FilterOption(label: 'All', value: 'all'),
  ...CombatElement.values.map(
    (e) =>
        FilterOption(label: e.name.capitalize(), value: e.name.toLowerCase()),
  ),
  ...SkillType.values
      .where((t) => t != SkillType.attack)
      .map(
        (t) => FilterOption(
          label: t.name.capitalize(),
          value: t.name.toLowerCase(),
        ),
      ),
];

final List<FilterOption> shadowFilterOptions = [
  FilterOption(label: 'All', value: 'all'),
  FilterOption(label: 'Thebel', value: 'thebel'),
  FilterOption(label: 'Monorail', value: 'monorail'),
  FilterOption(label: 'Arqa', value: 'arqa'),
  FilterOption(label: 'Yabbashah', value: 'yabbashah'),
  FilterOption(label: 'Tziah', value: 'tziah'),
  FilterOption(label: 'Harabah', value: 'harabah'),
  FilterOption(label: 'Adamah', value: 'adamah'),
  FilterOption(label: 'Tutorial', value: 'tutorial'),
  FilterOption(label: 'Ultimate', value: 'ultimate'),
  FilterOption(label: 'Boss', value: 'boss'),
  FilterOption(label: 'Other', value: 'unknown'),
];
