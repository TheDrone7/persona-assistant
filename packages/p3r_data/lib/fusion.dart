import 'package:pair/pair.dart';

import 'types/config.dart';
import 'types/fusions.dart';
import 'types/persona.dart';

class FusionCalculator {
  /// Key1 + Key2 = val2
  final Map<Arcana, Map<Arcana, Arcana>> fusionChart = {};

  /// Key = val1 + val2
  final Map<Arcana, List<Pair<Arcana, Arcana>>> reverseFusionChart = {};

  /// ignore arcana
  final Map<String, List<String>> specialFusions = {};

  /// Persona levels for each arcana that can be fused to create a new persona.
  final Map<Arcana, List<int>> ingredients = {};

  /// Persona levels for each arcana that can be created by fusion.
  final Map<Arcana, List<int>> results = {};

  /// Cache for persona lookups to avoid recalculating them.
  final Map<Pair<Arcana, int>, Persona> personaCache = {};

  final double _fusionLvlMod = 0.5;
  final double _sameArcanaMod = 1.0;

  /// Sets up the fusion chart based on the provided fusion table from the json file.
  /// This NEEDS to be called AFTER setting up the special fusions.
  /// And BEFORE adding the personas or using the calculator.
  ///
  /// [fusionTable] The fusion table from the json file.
  void _setupTable(List<dynamic> fusionTable) {
    fusionChart.clear();
    reverseFusionChart.clear();

    for (var (i, rowData) in fusionTable.indexed) {
      final arc = Arcana.values[i];
      final row = List<String>.from(rowData);

      for (var (j, cell) in row.indexed) {
        if (cell.isEmpty || cell == '-') continue;
        final arc2 = Arcana.values[j];
        final result = Arcana.fromString(cell);

        if (!fusionChart.containsKey(arc)) {
          fusionChart[arc] = {};
        }
        if (!fusionChart.containsKey(arc2)) {
          fusionChart[arc2] = {};
        }
        fusionChart[arc]![arc2] = result;
        fusionChart[arc2]![arc] = result;

        if (!reverseFusionChart.containsKey(result)) {
          reverseFusionChart[result] = [];
        }
        reverseFusionChart[result]!.add(Pair(arc, arc2));
      }
    }
  }

  /// Sets up the special fusions based on the provided specials list from the json file.
  /// This NEEDS to be called BEFORE setting up the fusion table.
  ///
  /// [specialsList] The specials list from the json file.
  void _setupSpecials(Map<String, dynamic> specialsList) {
    specialFusions.clear();

    for (var entry in specialsList.entries) {
      final key = entry.key;
      final values = List<String>.from(entry.value);
      specialFusions[key] = values;
    }
  }

  /// Adds a persona to the calculations for fusion.
  ///
  /// [persona] The persona to add to the calculations.
  void addPersona(Persona persona) {
    if (persona.unlockMethod == PersonaUnlockMethod.locked) {
      return;
    }
    final arcana = persona.arcana;
    final level = persona.level;

    if (!ingredients.containsKey(arcana)) {
      ingredients[arcana] = [];
    }
    if (!results.containsKey(arcana)) {
      results[arcana] = [];
    }

    if (!ingredients[arcana]!.contains(level)) {
      ingredients[arcana]!.add(level);
    }
    if (!results[arcana]!.contains(level) &&
        !specialFusions.containsKey(persona.name)) {
      results[arcana]!.add(level);
    }

    // Cache the persona for quick lookup
    personaCache[Pair(arcana, level)] = persona;
  }

  /// Removes a persona from the calculations for fusion.
  ///
  /// [persona] The persona to remove from the calculations.
  void removePersona(Persona persona) {
    final arcana = persona.arcana;
    final level = persona.level;

    ingredients[arcana]?.remove(level);
    results[arcana]?.remove(level);
    personaCache.removeWhere((key, val) => val.name == persona.name);
  }

  /// Initializes the fusion calculator.
  ///
  /// [personas] The list of personas to add to the calculations.
  /// [fusionTable] The fusion table from the json file.
  /// [specialsList] The specials list from the json file.
  void initialize(
    List<Persona> personas,
    List<dynamic> fusionTable,
    Map<String, dynamic> specialsList,
  ) {
    _setupSpecials(specialsList);
    _setupTable(fusionTable);

    ingredients.clear();
    for (var persona in personas) {
      addPersona(persona);
    }

    // Sort the levels for each arcana
    for (var arcana in ingredients.keys) {
      ingredients[arcana]!.sort();
      results[arcana]!.sort();
    }
  }

  /// Returns the fusion results for the given persona when fused with other arcanas.
  ///
  /// [source] The persona to get the fusion results for.
  List<FusionResult> getFusionResultsWithOther(Persona source) {
    final arcana = source.arcana;
    final level = source.level;

    if (!fusionChart.containsKey(arcana)) {
      return [];
    }

    final result = <FusionResult>[];

    for (var entry in fusionChart[arcana]!.entries) {
      final Arcana arcana2 = entry.key;
      final Arcana resultArcana = entry.value;

      final List<int> ingLevels = ingredients[arcana2]!;
      final List<int> resultLevels = results[resultArcana]!;

      final List<double> thresholdLevels = resultLevels.map((lvl) {
        return (2 * (lvl - _fusionLvlMod) - level);
      }).toList();

      for (var ing in ingLevels) {
        int thresholdIndex = thresholdLevels.where((t) => t <= ing).length;
        if (thresholdIndex == thresholdLevels.length) {
          thresholdIndex = thresholdLevels.length - 1;
        }

        if (level != ing && arcana != arcana2) {
          final Persona ingPersona = personaCache[Pair(arcana2, ing)]!;
          final Persona resultPersona =
              personaCache[Pair(resultArcana, resultLevels[thresholdIndex])]!;

          if (resultPersona.name == source.name &&
              thresholdIndex < (resultLevels.length - 1)) {
            final newResult =
                personaCache[Pair(
                  resultArcana,
                  resultLevels[thresholdIndex + 1],
                )];
            if (newResult != null) {
              result.add(
                FusionResult(ingredients: [ingPersona], result: newResult),
              );
            }
          } else {
            result.add(
              FusionResult(ingredients: [ingPersona], result: resultPersona),
            );
          }
        }
      }
    }

    return result;
  }

  /// Returns the fusion results for the given persona when fused with the same arcana.
  ///
  /// [source] The persona to get the fusion results for.
  List<FusionResult> getFusionResultsWithSame(Persona source) {
    final arcana = source.arcana;
    final level = source.level;

    if (!fusionChart.containsKey(arcana)) {
      return [];
    }

    final result = <FusionResult>[];

    final List<int> ingLevels = ingredients[arcana]!
        .where((lvl) => lvl != level)
        .toList();
    final List<int> resultLevels = results[arcana]!
        .where((lvl) => lvl != level)
        .map((lvl) => 2 * lvl)
        .toList();

    for (var ing in ingLevels) {
      int resultIndex = resultLevels.fold(
        -1,
        (a, r) => (level + ing + 2 * _sameArcanaMod >= r) ? a + 1 : a,
      );

      if (resultIndex < 0 || resultIndex >= resultLevels.length) {
        continue; // Skip if index is out of bounds
      } else if (resultLevels[resultIndex] / 2 == ing) {
        resultIndex--;
      }

      if (resultIndex < 0) {
        continue;
      }

      final int resultLevel = (resultLevels[resultIndex] / 2).toInt();
      final Persona ingPersona = personaCache[Pair(arcana, ing)]!;
      Persona resultPersona = personaCache[Pair(arcana, resultLevel)]!;

      result.add(
        FusionResult(ingredients: [ingPersona], result: resultPersona),
      );
    }

    return result;
  }

  /// Returns all of the fusion results for the given persona.
  ///
  /// [source] The persona to get the fusion results for.
  List<FusionResult> getFusionResults(Persona source) {
    final resultsWithOther = getFusionResultsWithOther(source);
    final resultsWithSame = getFusionResultsWithSame(source);

    return [...resultsWithOther, ...resultsWithSame];
  }

  /// Returns the fission options for the given persona when ingredient personas belong to different arcanas.
  ///
  /// [target] The persona to get the fission options for.
  List<FusionResult> getFissionOptionsFromOthers(Persona target) {
    final List<FusionResult> result = [];

    final targetArcana = target.arcana;
    final targetLevel = target.level;

    final targetLevels = results[targetArcana]!;
    final targetLevelIndex = targetLevels.indexOf(targetLevel);

    if (targetLevelIndex == -1) {
      return [];
    }

    final double minLevel = targetLevelIndex > 0
        ? 2 * (targetLevels[targetLevelIndex - 1] - _fusionLvlMod)
        : 0.0;
    final double maxLevel = targetLevelIndex < targetLevels.length - 1
        ? 2 * (targetLevel - _fusionLvlMod)
        : 200.0;

    final List<Pair<Arcana, Arcana>> fissionArcana =
        reverseFusionChart[targetArcana]!;

    for (var pair in fissionArcana) {
      final Arcana arcana1 = pair.key;
      final Arcana arcana2 = pair.value;

      for (var level1 in ingredients[arcana1]!) {
        final double minLevel2 = minLevel - level1;
        final double maxLevel2 = maxLevel - level1;

        for (var level2 in ingredients[arcana2]!) {
          if (minLevel2 < level2 &&
              level2 <= maxLevel2 &&
              (arcana1 != arcana2 || level1 < level2)) {
            final Persona? persona1 = personaCache[Pair(arcana1, level1)];
            final Persona? persona2 = personaCache[Pair(arcana2, level2)];

            if (persona1 == null || persona2 == null) {
              continue;
            }

            final fusionResult = FusionResult(
              ingredients: [persona1, persona2],
              result: target,
            );
            if (result.any((p) => p == fusionResult)) {
              continue; // Skip if this pair already exists
            }

            result.add(fusionResult);
          }
        }
      }
    }

    return result;
  }

  /// Returns the fission options for the given persona when ingredient personas belong to the same arcana.
  ///
  /// [target] The persona to get the fission options for.
  List<FusionResult> getFissionOptionsFromSame(Persona target) {
    final List<FusionResult> result = [];
    final targetArcana = target.arcana;
    final targetLevel = target.level;
    final targetLevels = results[targetArcana]!;
    final targetLevelIndex = targetLevels.indexOf(targetLevel);

    if (targetLevelIndex == -1) {
      return [];
    }

    final double minResultLevel = 2 * (targetLevel - _sameArcanaMod);
    final double maxResultLevel = targetLevelIndex < targetLevels.length - 1
        ? 2 * (targetLevels[targetLevelIndex + 1] - _sameArcanaMod)
        : 200.0;
    final double nextResultLevel = targetLevelIndex < targetLevels.length - 2
        ? targetLevels[targetLevelIndex + 2].toDouble()
        : 200.0;

    final ingredientLevels = ingredients[targetArcana]!
        .where((lvl) => lvl != targetLevel)
        .toList();

    final ingLevelM = maxResultLevel / 2 + _sameArcanaMod;

    for (var ingLevel2 in ingredientLevels) {
      if (ingLevelM < ingLevel2 && ingLevelM + ingLevel2 < nextResultLevel) {
        final Persona? persona1 = personaCache[Pair(targetArcana, ingLevel2)];
        final Persona? persona2 = personaCache[Pair(targetArcana, targetLevel)];

        if (persona1 != null && persona2 != null) {
          result.add(
            FusionResult(ingredients: [persona1, persona2], result: target),
          );
        }
      }
    }

    for (var i = 0; i < ingredientLevels.length; i++) {
      for (var j = i + 1; j < ingredientLevels.length; j++) {
        final ingLevel1 = ingredientLevels[i];
        final ingLevel2 = ingredientLevels[j];

        if (minResultLevel <= ingLevel1 + ingLevel2 &&
            ingLevel1 + ingLevel2 < maxResultLevel) {
          final Persona? persona1 = personaCache[Pair(targetArcana, ingLevel1)];
          final Persona? persona2 = personaCache[Pair(targetArcana, ingLevel2)];

          if (persona1 != null && persona2 != null) {
            result.add(
              FusionResult(ingredients: [persona1, persona2], result: target),
            );
          }
        }
      }
    }

    return result;
  }

  /// Returns all of the fission options for the given persona.
  ///
  /// [target] The persona to get the fission options for.
  List<FusionResult> getFissionOptions(Persona target) {
    final resultsFromOthers = getFissionOptionsFromOthers(target);
    final resultsFromSame = getFissionOptionsFromSame(target);

    return [...resultsFromOthers, ...resultsFromSame];
  }

  FusionResult? getSpecialFissions(Persona target) {
    final specialName = target.name;
    if (!specialFusions.containsKey(specialName)) {
      return null;
    }

    final specialRecipe = specialFusions[specialName]!;
    final ingredients = specialRecipe.map((name) {
      return personaCache.values.firstWhere((p) => p.name == name);
    }).toList();

    return FusionResult(ingredients: ingredients, result: target);
  }
}
