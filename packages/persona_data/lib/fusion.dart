import 'types/config.dart';
import 'types/persona.dart';
import 'package:pair/pair.dart';

class FusionCalculator {
  // Key1 + Key2 = val2
  final Map<Arcana, Map<Arcana, Arcana>> fusionChart = {};
  // Key = val1 + val2
  final Map<Arcana, Pair<Arcana, Arcana>> reverseFusionChart = {};
  // ignore arcana
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
        reverseFusionChart[result] = Pair(arc, arc2);
      }
    }
  }

  /// Sets up the special fusions based on the provided specials list from the json file.
  /// This NEEDS to be called BEFORE setting up the fusion table.
  void _setupSpecials(Map<String, dynamic> specialsList) {
    specialFusions.clear();

    for (var entry in specialsList.entries) {
      final key = entry.key;
      final values = List<String>.from(entry.value);
      specialFusions[key] = values;
    }
  }

  /// Adds a persona to the calculations for fusion.
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
  void removePersona(Persona persona) {
    final arcana = persona.arcana;
    final level = persona.level;

    ingredients[arcana]?.remove(level);
    results[arcana]?.remove(level);
    personaCache.removeWhere((key, val) => val.name == persona.name);
  }

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

  /// Returns the fusion result for the given arcana.
  List<Pair<Persona, Persona>> getFusionResultsWithOther(Persona source) {
    final arcana = source.arcana;
    final level = source.level;

    if (!fusionChart.containsKey(arcana)) {
      return [];
    }

    final result = <Pair<Persona, Persona>>[];

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
              result.add(Pair(ingPersona, newResult));
            }
          } else {
            result.add(Pair(ingPersona, resultPersona));
          }
        }
      }
    }

    return result;
  }

  List<Pair<Persona, Persona>> getFusionResultsWithSame(Persona source) {
    final arcana = source.arcana;
    final level = source.level;

    if (!fusionChart.containsKey(arcana)) {
      return [];
    }

    final result = <Pair<Persona, Persona>>[];

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

      final int resultLevel = (resultLevels[resultIndex] / 2).toInt();
      final Persona ingPersona = personaCache[Pair(arcana, ing)]!;
      Persona resultPersona = personaCache[Pair(arcana, resultLevel)]!;

      result.add(Pair(ingPersona, resultPersona));
    }

    return result;
  }
}
