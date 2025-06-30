import 'package:flutter/foundation.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert' show jsonDecode;

import 'types/skill.dart';
import 'types/persona.dart';
import 'types/shadow.dart';

/// The base class for managing all Persona data.
class PersonaData {
  final Map<int, PersonaSkill> _skills = {};
  final Map<String, Persona> _personas = {};
  final Map<String, PersonaShadow> _shadows = {};
  final List<String> _arcana = [
    'Fool',
    'Magician',
    'Priestess',
    'Empress',
    'Emperor',
    'Hierophant',
    'Lovers',
    'Chariot',
    'Justice',
    'Hermit',
    'Fortune',
    'Strength',
    'Hanged',
    'Death',
    'Temperance',
    'Devil',
    'Tower',
    'Star',
    'Moon',
    'Sun',
    'Judgement',
    'Aeon',
  ];

  /// Read the skills from the data source.
  Future<void> loadSkills() async {
    try {
      final String stringData = await rootBundle.loadString(
        'assets/p3r/jsons/skill-data.json',
      );
      final Map<String, dynamic> jsonData = jsonDecode(stringData);
      if (jsonData.isEmpty) {
        throw Exception('Skills data is empty');
      }
      if (kDebugMode) {
        debugPrint('${jsonData.length} Skills read, now processing...');
      }
      // Clear the existing skills before loading new ones
      _skills.clear();

      for (var entry in jsonData.entries) {
        final key = entry.key;
        final value = entry.value;

        if (value is Map<String, dynamic>) {
          final skill = PersonaSkill.fromJson(int.parse(key), value);
          if (skill.effect.trim().isNotEmpty) {
            _skills[skill.id] = skill;
          }
        } else {
          if (kDebugMode) {
            debugPrint('Invalid skill data for key: $key');
          }
        }
      }

      if (kDebugMode) {
        debugPrint('Skills loaded successfully: ${_skills.length} skills');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error loading skills: $e');
      }
    }
  }

  Future<void> loadShadows() async {
    if (_skills.isEmpty) {
      await loadSkills();
    }

    try {
      final String stringData = await rootBundle.loadString(
        'assets/p3r/jsons/enemy-data.json',
      );
      final Map<String, dynamic> jsonData = jsonDecode(stringData);
      if (jsonData.isEmpty) {
        throw Exception('Shadows data is empty');
      }
      if (kDebugMode) {
        debugPrint('${jsonData.length} Shadows read, now processing...');
      }
      // Clear the existing shadows before loading new ones
      _shadows.clear();

      for (var entry in jsonData.entries) {
        final key = entry.key;
        final value = entry.value;

        if (value is Map<String, dynamic>) {
          final shadow = PersonaShadow.fromJson(key, value);
          _shadows[key] = shadow;
        } else {
          if (kDebugMode) {
            debugPrint('Invalid shadow data for key: $key');
          }
        }
      }

      if (kDebugMode) {
        debugPrint('Shadows loaded successfully: ${_shadows.length} shadows');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error loading shadows: $e');
      }
    }
  }

  /// Read the personas from the data source.
  /// Sources:
  /// - `assets/p3r/jsons/demon-data.json` (Base persona data)
  /// - `assets/p3r/jsons/demon-unlocks.json` (Unlock conditions)
  /// - `assets/p3r/jsons/party-data.json` (Party personas)
  Future<void> loadPersonas() async {
    if (_skills.isEmpty) {
      await loadSkills();
    }

    try {
      final String stringData = await rootBundle.loadString(
        'assets/p3r/jsons/demon-data.json',
      );
      final unlockString = await rootBundle.loadString(
        'assets/p3r/jsons/demon-unlocks.json',
      );
      final partyString = await rootBundle.loadString(
        'assets/p3r/jsons/party-data.json',
      );
      final Map<String, dynamic> jsonData = jsonDecode(stringData);
      final List<dynamic> unlockData = jsonDecode(unlockString);
      final Map<String, dynamic> partyData = jsonDecode(partyString);

      if (jsonData.isEmpty || unlockData.isEmpty || partyData.isEmpty) {
        throw Exception('Personas or unlocks or party data is empty');
      }
      if (kDebugMode) {
        debugPrint(
          '${jsonData.length} Personas, ${unlockData.length} Unlocks, and ${partyData.length} Party Personas read, now processing...',
        );
      }
      Map<String, PersonaUnlockMethod> unlockMethods = {};
      Map<String, String?> unlockConditions = {};

      for (var unlockCategory in unlockData) {
        final String category = (unlockCategory['category'] as String)
            .toLowerCase();
        final Map<String, String> conditions = Map<String, String>.from(
          unlockCategory['conditions'],
        );
        for (var entry in conditions.entries) {
          final String personaName = entry.key;
          final String condition = entry.value;

          unlockConditions[personaName] = condition;

          if (category.contains('story')) {
            unlockMethods[personaName] = PersonaUnlockMethod.story;
          } else if (category.contains('social')) {
            unlockMethods[personaName] = PersonaUnlockMethod.social;
          } else if (category.contains('teammate')) {
            unlockMethods[personaName] = PersonaUnlockMethod.teammate;
          } else if (category.contains('downloadable')) {
            unlockMethods[personaName] = PersonaUnlockMethod.dlc;
          } else {
            unlockMethods[personaName] = PersonaUnlockMethod.level;
          }
        }
      }

      for (var personaName in partyData.keys) {
        unlockMethods[personaName] = PersonaUnlockMethod.locked;
        unlockConditions[personaName] = null;
        jsonData[personaName] = partyData[personaName];
      }

      // Clear the existing personas before loading new ones
      _personas.clear();

      for (var entry in jsonData.entries) {
        final key = entry.key;
        final value = entry.value;

        if (value is Map<String, dynamic>) {
          final persona = Persona.fromJson(
            key,
            value,
            _skills.values.toList(),
            unlockMethods[key] ?? PersonaUnlockMethod.level,
            unlockConditions[key],
          );
          _personas[key] = persona;
        } else {
          if (kDebugMode) {
            debugPrint('Invalid persona data for key: $key');
          }
        }
      }

      if (kDebugMode) {
        debugPrint(
          'Personas loaded successfully: ${_personas.length} personas',
        );
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error loading personas: $e');
      }
    }
  }

  Map<int, PersonaSkill> get skills => _skills;
  Map<String, Persona> get personas => _personas;
  Map<String, PersonaShadow> get shadows => _shadows;
  List<String> get arcana => _arcana;
}
