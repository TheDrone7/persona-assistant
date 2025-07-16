import 'config.dart';

/// Parses a string representation of ailment resistances into a map.
///
/// The input string should be 6 characters long, where each character represents
/// the resistance level for a specific ailment in order: charm, poison, distress,
/// confusion, fear, rage.
///
/// Valid characters: 'x' (normal), 'w'/'v'/'u'/'z' (weak), 's'/'t' (resist),
/// 'd' (drain), 'n' (nullify), 'r' (repel).
///
/// If the input is null or not 6 characters, defaults to all normal resistances.
///
/// Returns a map mapping each [Ailment] to its corresponding [ResistanceCode].
Map<Ailment, ResistanceCode> parseAilments(String? ailments) {
  if (ailments == null || ailments.length != 6) {
    ailments = '------';
  }

  Map<Ailment, ResistanceCode> ailmentMap = {};

  for (int i = 0; i < ailments.length; i++) {
    final char = ailments[i].toLowerCase();
    ResistanceCode affinity = ResistanceCode.fromString(char);
    ailmentMap[Ailment.values[i]] = affinity;
  }

  return ailmentMap;
}

/// Parses a string representation of combat element resistances into a map.
///
/// The input string should be 10 characters long, where each character represents
/// the resistance level for a specific combat element in order: slash, strike,
/// pierce, fire, ice, electric, wind, light, dark, almighty.
///
/// Valid characters: 'x' (normal), 'w'/'v'/'u'/'z' (weak), 's'/'t' (resist),
/// 'd' (drain), 'n' (nullify), 'r' (repel).
///
/// If the input is null or not 10 characters, defaults to all normal resistances.
///
/// Returns a map mapping each [CombatElement] to its corresponding [ResistanceCode].
Map<CombatElement, ResistanceCode> parseResistances(String? resistances) {
  if (resistances == null || resistances.length != 10) {
    resistances = '----------';
  }

  Map<CombatElement, ResistanceCode> affinityMap = {};

  for (int i = 0; i < resistances.length; i++) {
    final char = resistances[i].toLowerCase();
    ResistanceCode affinity = ResistanceCode.fromString(char);
    affinityMap[CombatElement.values[i]] = affinity;
  }

  return affinityMap;
}
