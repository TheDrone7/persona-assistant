import 'package:flutter/foundation.dart';
import 'dart:async' show Future;

import 'reader.dart';
import 'types/skill.dart';
import 'types/persona.dart';
import 'types/shadow.dart';

/// The base class for managing all Persona data.
class PersonaData {
  final PersonaConfigReader reader;
  PersonaData(this.reader);

  final Map<String, PersonaSkill> _skills = {};
  final Map<String, Persona> _personas = {};
  final Map<String, PersonaShadow> _shadows = {};

  /// Read the skills from the data source.
  Future<void> loadSkills() async {
    try {
      if (!reader.isReady) {
        await reader.loadConfig();
      }

      // Clear the existing skills before loading new ones
      _skills.clear();

      for (var entry in reader.skillData.entries) {
        final key = entry.key;
        final value = entry.value;

        if (value is Map<String, dynamic>) {
          final skill = PersonaSkill.fromJson(int.parse(key), value);
          _skills[skill.name] = skill;
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
      // Clear the existing shadows before loading new ones
      _shadows.clear();

      for (var entry in reader.enemyData.entries) {
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
  /// - `jsons/demon-data.json` (Base persona data)
  /// - `jsons/demon-unlocks.json` (Unlock conditions)
  /// - `jsons/party-data.json` (Party personas)
  Future<void> loadPersonas() async {
    if (_skills.isEmpty) {
      await loadSkills();
    }

    try {
      Map<String, PersonaUnlockMethod> unlockMethods = {};
      Map<String, String?> unlockConditions = {};
      Map<String, dynamic> jsonData = {};

      // Duplicate the data from the reader
      jsonData.addAll(reader.personaData);

      for (var unlockCategory in reader.unlockData) {
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

      for (var personaName in reader.partyData.keys) {
        unlockMethods[personaName] = PersonaUnlockMethod.locked;
        unlockConditions[personaName] = null;
        jsonData[personaName] = reader.partyData[personaName];
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
            unlockMethods[key] ?? PersonaUnlockMethod.level,
            unlockConditions[key],
          );
          _personas[key] = persona;

          for (MapEntry<String, int> entry in persona.skills.entries) {
            final skillName = entry.key;
            final skill = _skills[skillName];
            if (skill != null) {
              skill.addPersona(key, entry.value);
            } else if (kDebugMode) {
              debugPrint('Skill $skillName not found for persona $key');
            }
          }
        } else if (kDebugMode) {
          debugPrint('Invalid persona data for key: $key');
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

  Future<void> initialize() async {
    await reader.loadConfig();
    await loadSkills();
    await loadPersonas();
    await loadShadows();
  }

  Future<void> updatePreferences() async {
    // Ensure that the data is loaded before updating these.
    if (_skills.isEmpty || _personas.isEmpty || _shadows.isEmpty) {
      await initialize();
    }
  }

  Map<String, PersonaSkill> get skills => _skills;
  Map<String, Persona> get personas => _personas;
  Map<String, PersonaShadow> get shadows => _shadows;

  /// Creates a PersonaData instance from a given path.
  /// The path should point to the directory containing the JSON files.
  factory PersonaData.fromPath(String path) {
    return PersonaData(PersonaConfigReader(path));
  }
}
