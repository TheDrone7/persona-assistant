import 'package:persona_data/lib.dart';

/// Sorts a list of FusionResult objects.
///
/// Takes a list of fusion results and a sort type, then returns a new sorted list.
/// The sorting criteria is determined by the sortType parameter.
///
/// [fusionResults] The list of fusion results to sort.
/// [sortType] The type of sorting to apply.
/// Returns a new sorted list of FusionResult objects.
List<FusionResult> sortFusionResults(
  List<FusionResult> fusionResults,
  String sortType,
) {
  final sortedList = List<FusionResult>.from(fusionResults);

  if (sortType.isNotEmpty && int.tryParse(sortType[0]) != null) {
    final parts = sortType.split('_');
    final ingredientIndex = int.parse(parts[0]);
    final actualSortType = parts.skip(1).join('_');

    switch (actualSortType) {
      case 'name_asc':
        sortedList.sort(
          (a, b) => a.ingredients[ingredientIndex].name.compareTo(
            b.ingredients[ingredientIndex].name,
          ),
        );
        break;
      case 'name_desc':
        sortedList.sort(
          (a, b) => b.ingredients[ingredientIndex].name.compareTo(
            a.ingredients[ingredientIndex].name,
          ),
        );
        break;
      case 'arcana':
        sortedList.sort(
          (a, b) => a.ingredients[ingredientIndex].arcana.index.compareTo(
            b.ingredients[ingredientIndex].arcana.index,
          ),
        );
        break;
      case 'level_asc':
        sortedList.sort(
          (a, b) => a.ingredients[ingredientIndex].level.compareTo(
            b.ingredients[ingredientIndex].level,
          ),
        );
        break;
      case 'level_desc':
        sortedList.sort(
          (a, b) => b.ingredients[ingredientIndex].level.compareTo(
            a.ingredients[ingredientIndex].level,
          ),
        );
        break;
      case 'cost_asc':
        sortedList.sort(
          (a, b) => a.ingredients[ingredientIndex].price.compareTo(
            b.ingredients[ingredientIndex].price,
          ),
        );
        break;
      case 'cost_desc':
        sortedList.sort(
          (a, b) => b.ingredients[ingredientIndex].price.compareTo(
            a.ingredients[ingredientIndex].price,
          ),
        );
        break;
    }
  } else {
    switch (sortType) {
      case 'total_desc':
        sortedList.sort((a, b) => b.estimatedCost.compareTo(a.estimatedCost));
        break;
      case 'result_cost_asc':
        sortedList.sort((a, b) => a.result.price.compareTo(b.result.price));
        break;
      case 'result_cost_desc':
        sortedList.sort((a, b) => b.result.price.compareTo(a.result.price));
        break;
      case 'result_level_asc':
        sortedList.sort((a, b) => a.result.level.compareTo(b.result.level));
        break;
      case 'result_level_desc':
        sortedList.sort((a, b) => b.result.level.compareTo(a.result.level));
        break;
      case 'result_arcana':
        sortedList.sort(
          (a, b) => a.result.arcana.index.compareTo(b.result.arcana.index),
        );
        break;
      case 'result_name_asc':
        sortedList.sort((a, b) => a.result.name.compareTo(b.result.name));
        break;
      case 'result_name_desc':
        sortedList.sort((a, b) => b.result.name.compareTo(a.result.name));
        break;
      default:
        sortedList.sort((a, b) => a.estimatedCost.compareTo(b.estimatedCost));
        break;
    }
  }

  return sortedList;
}
