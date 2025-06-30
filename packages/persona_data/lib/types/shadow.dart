import 'element.dart';
import 'affinities.dart';
import 'persona.dart';

/// Represents a Shadow in the game.
class PersonaShadow {
  /// The shadow's resistances to various ailments.
  final Map<Ailment, Affinity> ailments;

  /// The shadow's resistances to combat elements.
  final Map<CombatElement, Affinity> affinities;

  /// The name of the shadow.
  final String name;

  /// The area where the shadow is encountered.
  final String areaEncountered;

  /// The drops that the shadow can give.
  final Map<String, int> drops;

  /// The experience points awarded for defeating the shadow.
  final int experience;

  /// The level of the shadow.
  final int level;

  /// The arcana of the shadow.
  final String arcana;

  /// The skills that the shadow can use (some shadows may have unique skills so these are not linked to PersonaSkills).
  final List<String> skills;

  /// The health points of the shadow.
  final int hp;

  /// The magic points of the shadow.
  final int mp;

  /// The stats of the shadow, represented as a map of PersonaStats to their values.
  final Map<PersonaStats, int> stats;

  /// Whether the shadow is a boss or not.
  final bool isBoss;

  PersonaShadow({
    required this.ailments,
    required this.affinities,
    required this.name,
    required this.areaEncountered,
    required this.drops,
    required this.experience,
    required this.level,
    required this.arcana,
    required this.skills,
    required this.hp,
    required this.mp,
    required this.stats,
    this.isBoss = false,
  });

  /// Returns the icon for the arcana of this shadow.
  String get arcanaIcon => '${arcana.toLowerCase()}.png';

  /// Parses the resistances from a string representation.
  factory PersonaShadow.fromJson(String name, Map<String, dynamic> json) {
    Map<CombatElement, Affinity> resistances = parseResistances(
      json['resists'] as String,
    );
    Map<Ailment, Affinity> ailments = parseAilments(
      (json['ailments'] ?? '------') as String,
    );

    List<int> jsonStats = List<int>.from(json['stats']);

    String arcana = (json['race'] as String).split(' ').first;
    if (arcana.toLowerCase() == 'unknown') {
      arcana = 'Chariot';
    }

    return PersonaShadow(
      ailments: ailments,
      affinities: resistances,
      name: name,
      areaEncountered: json['area'] as String,
      drops: Map<String, int>.from(json['dodds'] ?? {}),
      experience: json['exp'],
      level: json['lvl'],
      arcana: arcana,
      skills: List<String>.from(json['skills']),
      hp: jsonStats[0],
      mp: jsonStats[1],
      stats: {
        PersonaStats.strength: jsonStats[2],
        PersonaStats.magic: jsonStats[3],
        PersonaStats.endurance: jsonStats[4],
        PersonaStats.agility: jsonStats[5],
        PersonaStats.luck: jsonStats[6],
      },
      isBoss: json['boss'] ?? false,
    );
  }
}
