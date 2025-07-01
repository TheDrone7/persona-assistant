import 'package:persona_data/types/element.dart';

/// Represents the type of the skill.
/// - `attack`: Offensive skills that deal damage.
/// - `support`: Skills that provide buffs or other support effects.
/// - `recovery`: Skills that heal or restore HP/SP.
/// - `special`: Unique skills that don't fit into the other categories.
/// - `passive`: Skills that provide passive effects without direct action.
/// - `ailment`: Skills that inflict status ailments on enemies.
enum SkillType { attack, support, recovery, special, passive, ailment }

/// Represents the target of the skill.
/// - `singleFoe`: Targets a single enemy.
/// - `allFoes`: Targets all enemies.
/// - `universal`: Targets all characters (all allies and enemies).
/// - `singleAlly`: Targets a single ally.
/// - `allAllies`: Targets all allies.
/// - `party`: Targets the entire party (all allies).
/// - `randomAlly`: Targets a random ally.
/// - `self`: Targets the user of the skill.
enum SkillTarget {
  singleFoe,
  allFoes,
  universal,
  singleAlly,
  allAllies,
  party,
  randomAlly,
  self,
}

/// Represents the type of cost associated with the skill.
/// - `sp`: Using the skill costs SP.
/// - `hp`: Using the skill costs HP.
/// - `gauge`: Using the skill costs a gauge (like a special meter).
/// - `none`: The skill has no cost.
enum SkillCostType { gauge, hp, sp, none }

/// Represents a Persona's skill.
class PersonaSkill {
  PersonaSkill({
    required this.id,
    required this.name,
    required this.target,
    required this.type,
    required this.effect,
    this.element = CombatElement.almighty,
    this.cost = 0,
    this.costType = SkillCostType.sp,
    this.power = 0,
    required this.accuracy,
    this.critChance = 0,
    this.rank = 0,
    this.minHits = 1,
    this.maxHits = 1,
    this.skillCard,
    required this.icon,
  });

  /// The unique identifier for the skill.
  final int id;

  /// The name of the skill.
  final String name;

  /// The name of the skill icon file.
  /// Needs to be prefixed with the path to skill icons.
  final String icon;

  /// The type of the skill (e.g., attack, support, recovery).
  final SkillType type;

  /// The target of the skill (e.g., single foe, all allies).
  final SkillTarget target;

  /// The element associated with the skill (e.g., fire, ice, almighty).
  /// This is only relevant for attack skills.
  final CombatElement element;

  /// The cost of using the skill, depending on the `costType`.
  /// For SP, its a flat amount.
  /// For HP, it is a percentage of the user's HP.
  final int cost;

  /// The type of cost associated with the skill (e.g., SP, HP, gauge).
  final SkillCostType costType;

  /// A description of the skill's effect.
  final String effect;

  /// The power of the skill, which determines its damage output.
  /// Or for recovery skills, the amount of HP/SP restored.
  ///
  /// This also scales with the user's stats so it is not to be taken as a flat value.
  final int power;

  /// The accuracy of the skill, which determines the chance of it hitting the target.
  final int accuracy;

  /// The minimum number of hits the skill can deal.
  final int minHits;

  /// The maximum number of hits the skill can deal.
  final int maxHits;

  /// The chance of the skill landing a critical hit.
  final int critChance;

  /// The rank of the skill, which may determine its availability or strength.
  final int rank;

  /// The skill card
  final String? skillCard;

  /// Creates a PersonaSkill instance from a JSON object.
  ///
  /// The JSON object is as expected from skill-data.json asset file.
  factory PersonaSkill.fromJson(int id, Map<String, dynamic> json) {
    if (!json.containsKey('a') ||
        !json.containsKey('b') ||
        !json.containsKey('c')) {
      throw ArgumentError('Invalid skill data format');
    }

    // Parse the first line of the skill data
    List<String> firstLine = List<String>.from(json['a']);
    if (firstLine.length < 3) {
      throw ArgumentError('Invalid skill data format');
    }

    // Parse the first line
    String name = firstLine[0];

    String type = firstLine[1].toLowerCase();
    CombatElement element = CombatElement.values.firstWhere(
      (e) => e.name.toLowerCase().startsWith(type),
      orElse: () => CombatElement.almighty,
    );

    SkillType skillType;
    String iconName = '';
    switch (type) {
      case 'sup':
        skillType = SkillType.support;
        iconName = 'support.png';
        break;
      case 'pas':
        skillType = SkillType.passive;
        iconName = 'passive.png';
        break;
      case 'ail':
        skillType = SkillType.ailment;
        iconName = 'ailment.png';
        break;
      case 'rec':
        skillType = SkillType.recovery;
        iconName = 'recovery.png';
        break;
      case 'spe':
        skillType = SkillType.special;
        iconName = 'navi.png';
        break;
      default:
        skillType = SkillType.attack;
        iconName = '${element.name}.png';
    }

    String targetStr = firstLine[2].toLowerCase();
    SkillTarget target;
    switch (targetStr) {
      case '1 foe':
        target = SkillTarget.singleFoe;
        break;
      case 'all foes':
        target = SkillTarget.allFoes;
        break;
      case 'universal':
        target = SkillTarget.universal;
        break;
      case '1 ally':
        target = SkillTarget.singleAlly;
        break;
      case 'all allies':
        target = SkillTarget.allAllies;
        break;
      case 'party':
        target = SkillTarget.party;
        break;
      case 'rand allies':
        target = SkillTarget.randomAlly;
        break;
      default:
        target = SkillTarget.self;
    }

    // Parse the second line
    List<int> secondLine = List<int>.from(json['b']);
    if (secondLine.length < 8) {
      throw ArgumentError('Invalid skill data format');
    }

    int rank = 0;
    if (secondLine[0] > 0) {
      rank = secondLine[0];
    }

    int cost = secondLine[1];
    SkillCostType costType;
    if (cost > 0 && cost < 1000) {
      costType = SkillCostType.hp;
    } else if (cost > 1000 && cost < 2000) {
      costType = SkillCostType.sp;
      cost -= 1000; // Adjust cost for SP
    } else if (cost == 2001) {
      costType = SkillCostType.gauge;
      cost = 0; // Gauge skills typically don't have a cost value
    } else {
      costType = SkillCostType.none;
      cost = 0;
    }

    int power = secondLine[2];
    int minHits = secondLine[3];
    int maxHits = secondLine[4];
    int accuracy = secondLine[5];
    int critChance = secondLine[6];

    // The effect number is to be used with the third line
    int effectNum = secondLine[7];
    // Parse the third line
    List<String> thirdLine = List<String>.from(json['c']);
    if (thirdLine.length < 3) {
      throw ArgumentError('Invalid skill data format');
    }
    String effectType = thirdLine[0];
    String effectFormat = thirdLine[1];
    String? skillCard = (thirdLine[2].isEmpty || thirdLine[2] == '-')
        ? null
        : thirdLine[2];

    String effect = _parseSkillEffect(
      effectFormat,
      effectNum,
      effectType,
      power,
      skillType,
    );

    if (skillType == SkillType.recovery &&
        power > 0 &&
        effect == 'No extra effect.') {
      effect = 'Restores $power HP.';
    }

    effect = effect.replaceAll('dmg', 'damage');

    if (effect.toLowerCase() == 'hp restore.' &&
        skillType == SkillType.recovery) {
      effect = "Restores ${power > 0 ? power : 'some'} HP.";
    } else if (effect.toLowerCase() == 'sp restore.' &&
        skillType == SkillType.recovery) {
      effect = "Restores ${power > 0 ? power : 'some'} SP.";
    }

    return PersonaSkill(
      id: id,
      name: name,
      target: target,
      type: skillType,
      element: element,
      cost: cost,
      costType: costType,
      effect: effect,
      power: power,
      accuracy: accuracy,
      minHits: minHits,
      maxHits: maxHits,
      critChance: critChance,
      rank: rank,
      skillCard: skillCard,
      icon: iconName,
    );
  }
}

/// Parse the skill effect text from the format string.
String _parseSkillEffect(
  String format,
  int num,
  String text,
  int pwr,
  SkillType type,
) {
  // Handle placebo skills
  if (format == '-' && pwr == 0) {
    return '';
  }

  // Update the format number
  double effectNum = num.toDouble();
  if (effectNum > 1000) {
    effectNum = (effectNum - 1000) / 100;
  }

  // Update format strings to format placeholders
  switch (format) {
    case 'FMTExact':
      return '$effectNum% chance for $text.';
    case 'FMTFracDamage':
      return 'Reduces $text by ${effectNum.toInt()}%.';
    case 'FMTInstakillWhen':
      return '${effectNum.toInt()}% chance to instakill when target is inflicted with $text.';
    case 'FMTFoulBreathN':
      return 'Raises ailment susceptibility by ${effectNum.toInt()}%${type == SkillType.passive ? '' : ' for 3 turns'}.';
    case 'FMTPersonaLifeDrain':
      return 'Deals ${effectNum.toInt()} damage and $text.';
    case 'FMTBase':
      return '$text.';
    case 'FMTRecarm':
      return 'Revive with ${effectNum.toInt()}% HP.';
    case 'FMTCureAilment':
      if (text.startsWith('-kaja')) {
        return 'Removes all buffs on target.';
      }
      if (text.startsWith('-kunda')) {
        return 'Removes all debuffs on target.';
      }
      return '${effectNum.toInt()}% chance of curing $text.';
    case 'FMTResistElem':
      return 'Changes affinity against $text damage to resist${type == SkillType.passive ? '' : ' for 3 turns'}.';
    case 'FMTDrainElem':
      return 'Changes affinity against $text damage to absorb${type == SkillType.passive ? '' : ' for 3 turns'}.';
    case 'FMTRepelElem':
      return 'Changes affinity against $text damage to repel${type == SkillType.passive ? '' : ' for 3 turns'}.';
    case 'FMTNullElem':
      return 'Changes affinity against $text damage to null${type == SkillType.passive ? '' : ' for 3 turns'}.';
    case 'FMTPersonaKaja':
      return 'x${effectNum.toStringAsFixed(2)} $text${type == SkillType.passive ? '' : ' for 3 turns'}.';
    case 'FMTElemCharge':
      return 'Next $text attack deals x${effectNum.toStringAsFixed(2)} damage.';
    case 'FMTElemKarn':
      return 'Repel next $text attack.';
    case 'FMTElemBreak':
      return 'Removes resistance against $text damage${type == SkillType.passive ? '' : ' for 3 turns'}.';
    case 'FMTResistAilment':
      return 'Reduce chances of being inflicted with $text.';
    case 'FMTNullAilment':
      return 'Grants immunity to $text.';
    case 'FMTDodgeElem':
      return 'Evasion against $text damage x${effectNum.toStringAsFixed(2)}.';
    case 'FMTPersonaCounter':
      return '${effectNum.toInt()}% chance to repel $text attack.';
    case 'FMTRegenerateN':
      return 'Recovers ${effectNum.toInt()}% HP at the start of each turn.';
    case 'FMTInvigorateN':
      return 'Recovers ${effectNum.toInt()} SP at the start of each turn.';
    case 'FMTElemBoost':
      return 'x${effectNum.toStringAsFixed(2)} $text damage.';
    case 'FMTAilmentBoost':
      return 'x${effectNum.toStringAsFixed(2)} chance of inflicting $text.';
    case 'FMTAutoSkill':
      return 'Automatically uses $text at the start of combat.';
    case 'FMTTimes':
      return '$text x${effectNum.toStringAsFixed(2)}.';
    case 'FMTEndure':
      return 'Survive a fatal attack with 1 HP remaining.';
    case 'FMTEnduringSoul':
      return 'Revive with 100% HP after being dealt a fatal blow once per battle.';
    case 'FMTLifeAidN':
      return '${effectNum.toInt()}% $text at the end of battle.';
    case 'FMTHealBoost':
      return 'x${effectNum.toStringAsFixed(2)} healing effect.';
    case 'FMTGrowthN':
      return 'Gain ${effectNum.toInt()}% more EXP at the end of battle.';
    case 'FMTPlus':
      return '+${effectNum.toInt()}% $text.';
    case 'FMTPersonaLifeDrainN':
      return "Deals ${effectNum.toInt()} damage recovers some ${text.split(' ')[0]}.";
    case '-':
      // If the format is "-", it means no effect
      return 'No extra effect.';
    default:
      // If the format is not recognized, return the original format
      return format
          .replaceAll(
            '\$1',
            (num > 1000 ? effectNum.toStringAsFixed(2) : num.toString()),
          )
          .replaceAll('\$2', text);
  }
}
