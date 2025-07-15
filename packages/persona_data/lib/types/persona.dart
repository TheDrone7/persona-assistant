import 'package:intl/intl.dart';
import 'config.dart';
import 'affinities.dart';

/// A Persona's stats
enum PersonaStats { strength, magic, endurance, agility, luck }

/// How to unlock a Persona.
enum PersonaUnlockMethod { level, story, social, teammate, dlc, locked }

/// A Persona data model.
class Persona {
  Persona({
    required this.name,
    required this.arcana,
    required this.level,
    required this.resistances,
    required this.skills,
    required this.stats,
    this.fusionCondition,
    this.unlockMethod = PersonaUnlockMethod.level,
    this.inheritanceType = InheritanceTypes.none,
    this.hasSpecialFusion = false,
  });

  /// The name of the Persona.
  final String name;

  /// The arcana of the Persona.
  final Arcana arcana;

  /// The method used to unlock the Persona.
  final PersonaUnlockMethod unlockMethod;

  /// The detailed fusion condition of the Persona, if not level.
  final String? fusionCondition;

  /// The base level of the Persona.
  /// This is the level at which the Persona can be fused.
  final int level;

  /// The resistances of the Persona to various elements.
  final Map<CombatElement, ResistanceCode> resistances;

  /// The skills that the Persona can learn.
  /// The keys are the skill names, and the values are the levels at which they are learned.
  /// Level 0 means the skill is an innate skill (Persona knows it already when fused or obtained).
  final Map<String, int> skills;

  /// The base stats of the Persona.
  final Map<PersonaStats, int> stats;

  /// The types of skills this persona can inherit when fused.
  final InheritanceTypes inheritanceType;

  /// Whether the Persona has a special fusion.
  final bool hasSpecialFusion;

  /// A shorter form of the condition for unlocking the persona.
  /// Should be used alongside the `fusionCondition` if it is not null.
  String get conditionShort {
    switch (unlockMethod) {
      case PersonaUnlockMethod.level:
        return 'Level $level';
      case PersonaUnlockMethod.story:
        return 'Story Progression';
      case PersonaUnlockMethod.social:
        return 'Social Link';
      case PersonaUnlockMethod.teammate:
        return 'Teammate Link';
      case PersonaUnlockMethod.dlc:
        return 'DLC';
      case PersonaUnlockMethod.locked:
        return 'Locked';
    }
  }

  /// The price of the Persona (estimated using stats).
  int get price {
    final total = stats.values.fold<int>(0, (acc, val) => acc + val);
    return 2000 + (total * total);
  }

  /// Formatted price of the persona (displayed with Yen symbol)
  String get formattedPrice {
    final formatter = NumberFormat.currency(
      locale: 'en_US',
      symbol: '\u00a5',
      decimalDigits: 0,
    );
    return formatter.format(price);
  }

  /// Creates a Persona from a JSON object.
  /// The [name] is used as the key to find the Persona in the JSON.
  /// The [json] is the JSON object containing the Persona data.
  /// The [unlockMethod] is the method used to unlock the Persona.
  /// The [fusionCondition] is the condition for the Persona to be fused.
  /// The [hasSpecialFusion] is whether the Persona has a special fusion.
  ///
  /// Returns the Persona object.
  factory Persona.fromJson(
    String name,
    Map<String, dynamic> json,
    PersonaUnlockMethod unlockMethod,
    String? fusionCondition,
    bool hasSpecialFusion,
  ) {
    int level = json['lvl'] as int;

    Map<CombatElement, ResistanceCode> resistances = parseResistances(
      json['resists'] as String?,
    );

    Map<String, int> skills = {};
    Map<String, dynamic> skillsJson = Map<String, dynamic>.from(json['skills']);
    for (var entry in skillsJson.entries) {
      skills[entry.key] = (entry.value.toDouble()).floor().toInt();
    }

    List<int> jsonStats = List<int>.from(json['stats']);
    Map<PersonaStats, int> stats = {
      PersonaStats.strength: jsonStats[0],
      PersonaStats.magic: jsonStats[1],
      PersonaStats.endurance: jsonStats[2],
      PersonaStats.agility: jsonStats[3],
      PersonaStats.luck: jsonStats[4],
    };

    String arcana = json['race'] as String;

    if (arcana.contains(' ')) {
      arcana = arcana.split(' ').first;
    }

    return Persona(
      name: name,
      arcana: Arcana.fromString(arcana),
      level: level,
      fusionCondition: fusionCondition,
      unlockMethod: unlockMethod,
      resistances: resistances,
      skills: skills,
      stats: stats,
      inheritanceType: InheritanceTypes.fromString(json['inherits'] as String?),
      hasSpecialFusion: hasSpecialFusion,
    );
  }
}
