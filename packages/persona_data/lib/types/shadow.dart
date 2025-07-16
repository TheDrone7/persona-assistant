import 'affinities.dart';
import 'config.dart';
import 'persona.dart';

/// Represents a Shadow in the game.
class PersonaShadow {
  /// The shadow's resistances to various ailments.
  final Map<Ailment, ResistanceCode> ailments;

  /// The shadow's resistances to combat elements.
  final Map<CombatElement, ResistanceCode> affinities;

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
  final Arcana arcana;

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

  /// Creates a new PersonaShadow object.
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

  /// Creates a new PersonaShadow object from a JSON object.
  /// The [name] is used as the key to find the Persona in the JSON.
  /// The [json] is the JSON object containing the Persona data.
  ///
  /// Returns the PersonaShadow object.
  factory PersonaShadow.fromJson(String name, Map<String, dynamic> json) {
    Map<CombatElement, ResistanceCode> resistances = parseResistances(
      json['resists'] as String,
    );
    Map<Ailment, ResistanceCode> ailments = parseAilments(
      json['ailments'] as String?,
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
      arcana: Arcana.fromString(arcana),
      skills: List<String>.from(
        json['skills'],
      ).map((s) => s == 'Phys Attack' ? 'Attack' : s).toList(),
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
