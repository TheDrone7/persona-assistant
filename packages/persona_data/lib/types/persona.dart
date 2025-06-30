import 'package:persona_data/types/element.dart';
import 'package:persona_data/types/affinities.dart';
import 'package:persona_data/types/skill.dart';

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
  });

  /// The name of the Persona.
  final String name;

  /// The arcana of the Persona.
  final String arcana;

  /// The method used to unlock the Persona.
  final PersonaUnlockMethod unlockMethod;

  /// The detailed fusion condition of the Persona, if not level.
  final String? fusionCondition;

  /// The base level of the Persona.
  /// This is the level at which the Persona can be fused.
  final int level;

  /// The resistances of the Persona to various elements.
  final Map<CombatElement, Affinity> resistances;

  /// The skills that the Persona can learn.
  /// The keys are the skills, and the values are the levels at which they are learned.
  /// Level 0 means the skill is an innate skill (Persona knows it already when fused or obtained).
  final Map<PersonaSkill, int> skills;

  /// The base stats of the Persona.
  final Map<PersonaStats, int> stats;

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

  /// The icon for the arcana of the Persona.
  /// Needs to be prefixed with the path to the icons.
  String get arcanaIcon => '${arcana.toLowerCase()}.png';

  /// Creates a Persona from a JSON object.
  /// The [name] is used as the key to find the Persona in the JSON.
  /// The [allSkills] list is used to find the skills by name.
  /// The [json] is the JSON object containing the Persona data.
  factory Persona.fromJson(
    String name,
    Map<String, dynamic> json,
    List<PersonaSkill> allSkills,
    PersonaUnlockMethod unlockMethod,
    String? fusionCondition,
  ) {
    int level = json['lvl'] as int;

    Map<CombatElement, Affinity> resistances = parseResistances(
      json['resists'] as String,
    );

    Map<PersonaSkill, int> skills = {};
    Map<String, dynamic> skillsJson = Map<String, dynamic>.from(json['skills']);
    for (var entry in skillsJson.entries) {
      PersonaSkill skill = allSkills.firstWhere((s) => s.name == entry.key);
      skills[skill] = (entry.value.toDouble()).floor().toInt();
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
      arcana: arcana,
      level: level,
      fusionCondition: fusionCondition,
      unlockMethod: unlockMethod,
      resistances: resistances,
      skills: skills,
      stats: stats,
    );
  }
}
