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
