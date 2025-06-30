import 'element.dart';

enum Affinity { weak, resist, nullify, repel, absorb, normal }

Map<Ailment, Affinity> parseAilments(String ailments) {
  if (ailments.length != 6) {
    throw ArgumentError('Invalid ailments format');
  }

  Map<Ailment, Affinity> ailmentMap = {};
  List<Ailment> ailmentTypes = [
    Ailment.charm,
    Ailment.poison,
    Ailment.distress,
    Ailment.confusion,
    Ailment.fear,
    Ailment.rage,
  ];

  for (int i = 0; i < ailments.length; i++) {
    final char = ailments[i].toLowerCase();
    Affinity affinity;

    switch (char) {
      case 'w':
      case 'v':
      case 'z':
        affinity = Affinity.weak;
        break;
      case 'r':
        affinity = Affinity.repel;
        break;
      case 'n':
        affinity = Affinity.nullify;
        break;
      case 'd':
        affinity = Affinity.absorb;
        break;
      case 's':
      case 't':
        affinity = Affinity.resist;
        break;
      default:
        affinity = Affinity.normal;
    }

    ailmentMap[ailmentTypes[i]] = affinity;
  }

  return ailmentMap;
}

Map<CombatElement, Affinity> parseResistances(String resistances) {
  if (resistances.length != 10) {
    throw ArgumentError('Invalid resistances format');
  }

  Map<CombatElement, Affinity> affinityMap = {};
  List<CombatElement> elements = [
    CombatElement.slash,
    CombatElement.strike,
    CombatElement.pierce,
    CombatElement.fire,
    CombatElement.ice,
    CombatElement.electric,
    CombatElement.wind,
    CombatElement.light,
    CombatElement.dark,
    CombatElement.almighty,
  ];

  for (int i = 0; i < resistances.length; i++) {
    final char = resistances[i].toLowerCase();
    Affinity affinity;

    switch (char.toLowerCase()) {
      case 'w':
      case 'v':
      case 'z':
        affinity = Affinity.weak;
        break;
      case 'r':
        affinity = Affinity.repel;
        break;
      case 'n':
        affinity = Affinity.nullify;
        break;
      case 'd':
        affinity = Affinity.absorb;
        break;
      case 's':
      case 't':
        affinity = Affinity.resist;
        break;
      default:
        affinity = Affinity.normal;
    }

    affinityMap[elements[i]] = affinity;
  }

  return affinityMap;
}
