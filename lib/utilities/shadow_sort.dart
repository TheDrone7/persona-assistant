import 'package:p3r_data/lib.dart';
import '../types/filters.dart';

/// Sorts a list of PersonaShadow objects.
///
/// Takes a list of shadows and a sort type, then returns a new sorted list.
/// The sorting criteria is determined by the sortType parameter.
///
/// [shadows] The list of shadows to sort.
/// [sortType] The type of sorting to apply.
/// Returns a new sorted list of PersonaShadow objects.
List<PersonaShadow> sortShadows(List<PersonaShadow> shadows, String sortType) {
  final sortedList = List<PersonaShadow>.from(shadows);

  switch (sortType) {
    case 'level_desc':
      sortedList.sort(
        (a, b) => b.level.compareTo(a.level) != 0
            ? b.level.compareTo(a.level)
            : a.name.compareTo(b.name),
      );
      break;
    case 'name_asc':
      sortedList.sort(
        (a, b) => a.name.compareTo(b.name) != 0
            ? a.name.compareTo(b.name)
            : a.level.compareTo(b.level),
      );
      break;
    case 'name_desc':
      sortedList.sort(
        (a, b) => b.name.compareTo(a.name) != 0
            ? b.name.compareTo(a.name)
            : a.level.compareTo(b.level),
      );
      break;
    case 'arcana':
      sortedList.sort((a, b) {
        if (a.arcana.index != b.arcana.index) {
          return a.arcana.index.compareTo(b.arcana.index);
        }
        if (a.level != b.level) {
          return a.level.compareTo(b.level);
        }
        if (a.name != b.name) {
          return a.name.compareTo(b.name);
        }
        return 0; // If all are equal, maintain original order
      });
      break;
    default:
      sortedList.sort(
        (a, b) => a.level.compareTo(b.level) != 0
            ? a.level.compareTo(b.level)
            : a.name.compareTo(b.name),
      );
      break;
  }

  return sortedList;
}

/// Filters a list of PersonaShadow objects.
///
/// Takes a list of shadows and filter criteria, then returns a new filtered list.
///
/// [shadows] The list of shadows to filter.
/// [shadowFilter] The shadow filter to apply.
/// Returns a new filtered list of PersonaShadow objects.
List<PersonaShadow> filterShadows(
  List<PersonaShadow> shadows,
  FilterOption shadowFilter,
) {
  List<PersonaShadow> filteredList = List<PersonaShadow>.from(shadows);

  // Apply shadow filter
  if (shadowFilter.value != 'all' && shadowFilter.value != 'boss') {
    filteredList = filteredList
        .where(
          (s) => s.areaEncountered.toLowerCase().startsWith(shadowFilter.value),
        )
        .toList();
  } else if (shadowFilter.value == 'boss') {
    filteredList = filteredList.where((s) => s.isBoss).toList();
  }

  return filteredList;
}
