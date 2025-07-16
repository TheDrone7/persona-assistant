import 'package:flutter/widgets.dart' show WidgetsFlutterBinding;
import 'package:flutter_test/flutter_test.dart';
import 'package:p3r_data/lib.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  PersonaData personaData = PersonaData.fromPath('assets/p3r/jsons');

  setUp(() async {
    await personaData.initialize(null);
  });

  group('Data loading', () {
    test('PersonaData should load skills and personas', () {
      expect(personaData.skills.isNotEmpty, true);
      expect(personaData.personas.isNotEmpty, true);
      expect(personaData.shadows.isNotEmpty, true);
    });

    test('Skills should have correct properties', () {
      PersonaSkill? skill = personaData.skills['Agi'];
      expect(skill, isNotNull);

      expect(skill!.name, 'Agi');
      expect(skill.id, 10);
      expect(skill.element, CombatElement.fire);
      expect(skill.cost, 3);
      expect(skill.costType, SkillCostType.sp);
      expect(skill.rank, 2);
      expect(skill.type, SkillType.attack);
      expect(skill.target, SkillTarget.singleFoe);

      expect(skill.power, 40);
      expect(skill.accuracy, 99);
      expect(skill.minHits, 1);
      expect(skill.maxHits, 1);
      expect(skill.critChance, 0);

      expect(skill.imagePath, 'images/skills/fire.png');
      expect(skill.skillCard, 'Sword 2');
    });

    test('Persona should have correct properties', () {
      Persona? persona = personaData.personas['Surt'];
      expect(persona, isNotNull);

      // Check basic properties
      expect(persona!.name, 'Surt');
      expect(persona.arcana, Arcana.magician);
      expect(persona.conditionShort, 'Teammate Link');
      expect(persona.arcana.imagePath, 'images/arcana/magician.png');
      expect(persona.level, 60);
      expect(persona.inheritanceType, InheritanceTypes.fireA);

      // Check resistances
      expect(persona.resistances[CombatElement.fire], ResistanceCode.d);
      expect(persona.resistances[CombatElement.ice], ResistanceCode.w);
      expect(persona.resistances[CombatElement.slash], ResistanceCode.x);

      // Check stats
      expect(persona.stats[PersonaStats.strength], 43);
      expect(persona.stats[PersonaStats.magic], 51);
      expect(persona.stats[PersonaStats.endurance], 40);
      expect(persona.stats[PersonaStats.agility], 28);
      expect(persona.stats[PersonaStats.luck], 34);

      // Check skills
      expect(persona.skills.length, 7);
      for (var skill in persona.skills.keys) {
        expect(skill.isNotEmpty, true);
      }
    });

    test('Fusions should work correctly', () {
      final fusionCalculator = personaData.fusionCalculator;
      final persona1 = personaData.personas['Orpheus']!;

      final others = fusionCalculator.getFusionResultsWithOther(persona1);
      expect(others.isNotEmpty, true);
      expect(others.length, 164);

      final sames = fusionCalculator.getFusionResultsWithSame(persona1);
      expect(sames.isNotEmpty, true);
      expect(sames.length, 7);
    });
  });

  test('Fissions should work correctly', () {
    final fusionCalculator = personaData.fusionCalculator;
    final targetPersona = personaData.personas['Jack Frost']!;
    final fissionOptions = fusionCalculator.getFissionOptions(targetPersona);

    expect(fissionOptions.isNotEmpty, true);
    expect(fissionOptions.length, 14);
  });
}
