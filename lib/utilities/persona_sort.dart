import 'package:persona_data/lib.dart';
import 'package:persona_assistant/types/filters.dart';

/// Sorts a list of Persona objects.
///
/// Takes a list of personas and a sort type, then returns a new sorted list.
/// The sorting criteria is determined by the sortType parameter.
///
/// [personas] The list of personas to sort.
/// [sortType] The type of sorting to apply.
/// Returns a new sorted list of Persona objects.
List<Persona> sortPersonas(List<Persona> personas, String sortType) {
  final sortedList = List<Persona>.from(personas);
  
  switch (sortType) {
    case 'level_asc':
      sortedList.sort((a, b) => a.level.compareTo(b.level));
      break;
    case 'level_desc':
      sortedList.sort((a, b) => b.level.compareTo(a.level));
      break;
    case 'name_asc':
      sortedList.sort((a, b) => a.name.compareTo(b.name));
      break;
    case 'name_desc':
      sortedList.sort((a, b) => b.name.compareTo(a.name));
      break;
    default:
      sortedList.sort((a, b) {
        return (a.arcana.index - b.arcana.index) != 0
            ? a.arcana.index - b.arcana.index
            : (a.unlockMethod.index - b.unlockMethod.index) != 0
            ? a.unlockMethod.index - b.unlockMethod.index
            : (a.level - b.level) != 0
            ? a.level - b.level
            : a.name.compareTo(b.name);
      });
      break;
  }
  
  return sortedList;
}

/// Filters a list of Persona objects.
///
/// Takes a list of personas and filter criteria, then returns a new filtered list.
///
/// [personas] The list of personas to filter.
/// [arcanaFilter] The arcana filter to apply.
/// [personaUnlocks] Map of persona names to their unlock status.
/// Returns a new filtered list of Persona objects.
List<Persona> filterPersonas(
  List<Persona> personas,
  FilterOption arcanaFilter,
  Map<String, bool> personaUnlocks,
) {
  List<Persona> filteredList = List<Persona>.from(personas);

  // Apply arcana filter
  if (arcanaFilter.value != 'all') {
    filteredList = filteredList
        .where((p) => p.arcana.name == arcanaFilter.value)
        .toList();
  }

  // Apply unlocks filter
  filteredList = filteredList.where((p) => personaUnlocks[p.name] ?? true).toList();

  return filteredList;
} 