import 'package:flutter/widgets.dart' show WidgetsFlutterBinding;
import 'package:flutter_test/flutter_test.dart';
import 'package:persona_data/lib.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  PersonaData personaData = PersonaData.fromPath('assets/p3r/jsons');

  setUp(() async {
    await personaData.loadSkills();
    await personaData.loadPersonas();
    await personaData.loadShadows();
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
      Persona? persona = personaData.personas['Arsene'];
      expect(persona, isNotNull);

      // Check basic properties
      expect(persona!.name, 'Arsene');
      expect(persona.arcana, Arcana.fool);
      expect(persona.conditionShort, 'DLC');
      expect(persona.arcana.imagePath, 'images/arcana/fool.png');
      expect(persona.level, 23);

      // Check resistances
      expect(persona.resistances[CombatElement.light], ResistanceCode.w);
      expect(persona.resistances[CombatElement.dark], ResistanceCode.s);
      expect(persona.resistances[CombatElement.slash], ResistanceCode.x);

      // Check stats
      expect(persona.stats[PersonaStats.strength], 17);
      expect(persona.stats[PersonaStats.magic], 17);
      expect(persona.stats[PersonaStats.endurance], 14);
      expect(persona.stats[PersonaStats.agility], 18);
      expect(persona.stats[PersonaStats.luck], 11);

      // Check skills
      expect(persona.skills.length, 7);
      for (var skill in persona.skills.keys) {
        expect(skill.isNotEmpty, true);
      }
    });
  });
}
