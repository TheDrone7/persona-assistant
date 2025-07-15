import 'package:intl/intl.dart';
import 'persona.dart';

/// Represents the result of a fusion operation.
class FusionResult {
  /// Creates a new FusionResult.
  ///
  /// [ingredients] The list of Persona objects used as ingredients in the fusion.
  /// [result] The resulting Persona from the fusion.
  FusionResult({required this.ingredients, required this.result});

  /// The list of Persona objects used as ingredients in the fusion.
  final List<Persona> ingredients;

  /// The resulting Persona from the fusion.
  final Persona result;

  /// Returns a new FusionResult with all ingredients excluding the provided Persona.
  ///
  /// [persona] The Persona to exclude from the ingredients list.
  FusionResult otherThan(Persona persona) {
    final filteredIngredients = ingredients
        .where((ingredient) => ingredient.name != persona.name)
        .toList();
    return FusionResult(ingredients: filteredIngredients, result: result);
  }

  /// The estimated cost of all ingredients combined.
  int get estimatedCost {
    return ingredients.fold<int>(
      0,
      (sum, ingredient) => sum + ingredient.price,
    );
  }

  /// Formatted cost of all ingredients combined (displayed with Yen symbol).
  String get formattedCost {
    return NumberFormat.currency(
      locale: 'en_US',
      symbol: '\u00a5',
      decimalDigits: 0,
    ).format(estimatedCost);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! FusionResult) return false;

    if (ingredients.length != other.ingredients.length) return false;

    for (int i = 0; i < ingredients.length; i++) {
      if (ingredients[i].name != other.ingredients[i].name) return false;
    }

    return result.name == other.result.name;
  }

  @override
  int get hashCode =>
      Object.hashAll([...ingredients.map((i) => i.name), result.name]);
}
