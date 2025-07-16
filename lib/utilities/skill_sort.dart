import 'package:persona_data/lib.dart';
import '../types/filters.dart';

/// Sorts a list of PersonaSkill objects.
///
/// Takes a list of skills and a sort type, then returns a new sorted list.
/// The sorting criteria is determined by the sortType parameter.
///
/// [skills] The list of skills to sort.
/// [sortType] The type of sorting to apply.
/// Returns a new sorted list of PersonaSkill objects.
List<PersonaSkill> sortSkills(List<PersonaSkill> skills, String sortType) {
  final sortedList = List<PersonaSkill>.from(skills);

  switch (sortType) {
    case 'name_asc':
      sortedList.sort((a, b) => a.name.compareTo(b.name));
      break;
    case 'name_desc':
      sortedList.sort((a, b) => b.name.compareTo(a.name));
      break;
    case 'cost_asc':
      sortedList.sort((a, b) {
        final aType = a.costType.index == 3 ? -1 : a.costType.index;
        final bType = b.costType.index == 3 ? -1 : b.costType.index;
        return bType.compareTo(aType) != 0
            ? bType.compareTo(aType)
            : a.cost.compareTo(b.cost);
      });
      break;
    case 'cost_desc':
      sortedList.sort(
        (a, b) => a.costType.index.compareTo(b.costType.index) != 0
            ? a.costType.index.compareTo(b.costType.index)
            : b.cost.compareTo(a.cost),
      );
      break;
    case 'rank_asc':
      sortedList.sort(
        (a, b) => (a.rank == 0 ? (-1 >>> 1) : a.rank).compareTo(
          (b.rank == 0 ? (-1 >>> 1) : b.rank),
        ),
      );
      break;
    case 'rank_desc':
      sortedList.sort((a, b) => b.rank.compareTo(a.rank));
      break;
    default:
      sortedList.sort(
        (a, b) => a.type.index.compareTo(b.type.index) != 0
            ? a.type.index.compareTo(b.type.index)
            : a.element.index.compareTo(b.element.index) != 0
            ? a.element.index.compareTo(b.element.index)
            : a.name.compareTo(b.name),
      );
      break;
  }

  return sortedList;
}

/// Filters a list of PersonaSkill objects.
///
/// Takes a list of skills and filter criteria, then returns a new filtered list.
///
/// [skills] The list of skills to filter.
/// [skillFilter] The skill filter to apply.
/// Returns a new filtered list of PersonaSkill objects.
List<PersonaSkill> filterSkills(
  List<PersonaSkill> skills,
  FilterOption skillFilter,
) {
  List<PersonaSkill> filteredList = List<PersonaSkill>.from(skills);

  // Apply skill filter
  if (skillFilter.value != 'all') {
    // Check if the filter is a combat element
    final isCombat = CombatElement.values.any(
      (e) => e.name.toLowerCase() == skillFilter.value.toLowerCase(),
    );

    if (isCombat) {
      filteredList = filteredList
          .where(
            (s) =>
                s.element.name.toLowerCase() == skillFilter.value &&
                s.type == SkillType.attack,
          )
          .toList();
    } else {
      filteredList = filteredList
          .where((s) => s.type.name.toLowerCase() == skillFilter.value)
          .toList();
    }
  }

  return filteredList;
}
