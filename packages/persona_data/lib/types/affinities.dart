import 'config.dart';

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
