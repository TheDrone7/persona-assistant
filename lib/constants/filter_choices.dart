import 'package:persona_assistant/types/extensions.dart';
import 'package:persona_assistant/types/filters.dart';
import 'package:persona_data/lib.dart';

final List<FilterOption> personaFilterOptions = [
  FilterOption(label: 'All', value: 'all'),
  ...PersonaData().arcana.map(
    (a) => FilterOption(label: a.capitalize(), value: a.toLowerCase()),
  ),
];
