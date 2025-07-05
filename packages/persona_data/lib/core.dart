import 'package:flutter/foundation.dart';
import 'dart:async' show Future;

import 'reader.dart';
import 'fusion.dart';
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
  final Map<String, bool> _personaUnlocked = {};
  final Map<String, bool> _defaultUnlocked = {};

  final FusionCalculator fusionCalculator = FusionCalculator();

  /// Process the skills read from the data source.
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

  /// Process the shadows read from the data source.
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

  /// Process the persona data read from the JSON files.
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
        final bool defaultValue = unlockCategory['unlocked'] as bool;
        final Map<String, String> conditions = Map<String, String>.from(
          unlockCategory['conditions'],
        );
        for (var entry in conditions.entries) {
          final String personaName = entry.key;
          final String condition = entry.value;

          unlockConditions[personaName] = condition;
          _defaultUnlocked[personaName] = defaultValue;

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
            reader.specialData.containsKey(key),
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

  /// Set the unlocked status of a persona.
  bool setPersonaUnlocked(String name, bool unlocked) {
    if (_personas.containsKey(name)) {
      _personaUnlocked[name] = unlocked;
      if (unlocked) {
        fusionCalculator.addPersona(_personas[name]!);
      } else {
        fusionCalculator.removePersona(_personas[name]!);
      }
      return true;
    } else {
      if (kDebugMode) {
        debugPrint('Persona $name not found in the data.');
      }
      return false;
    }
  }

  /// Initialize the library for use by loading and processing all data.
  Future<void> initialize(Map<String, bool>? unlocks) async {
    await reader.loadConfig();
    await loadSkills();
    await loadPersonas();
    await loadShadows();

    fusionCalculator.initialize(
      _personas.values.toList(),
      List<dynamic>.from(reader.fusionData['table']),
      Map<String, dynamic>.from(reader.specialData),
    );

    unlocks ??= _defaultUnlocked;
    for (var entry in unlocks.entries) {
      final String personaName = entry.key;
      final bool unlocked = entry.value;
      setPersonaUnlocked(personaName, unlocked);
    }
  }

  /// The map of all skills available in the game.
  Map<String, PersonaSkill> get skills => _skills;

  /// The map of all unlockable personas and their unlock status.
  Map<String, bool> get personaUnlocked => _personaUnlocked;

  /// Unlockable personas are the ones that can be toggled in the app.
  Map<String, Persona> get unlockablePersonas {
    final Map<String, Persona> unlockable = {};
    _personas.forEach((key, persona) {
      if (persona.unlockMethod != PersonaUnlockMethod.locked &&
          persona.unlockMethod != PersonaUnlockMethod.level) {
        unlockable[key] = persona;
      }
    });
    return unlockable;
  }

  /// Returns a map of unlocked personas for most of the app logic.
  Map<String, Persona> get personas {
    final Map<String, Persona> unlockedPersonas = {};
    _personas.forEach((key, persona) {
      if (_personaUnlocked[key] ?? true) {
        unlockedPersonas[key] = persona;
      }
    });
    return unlockedPersonas;
  }

  /// Returns a map of all shadows in the game.
  Map<String, PersonaShadow> get shadows => _shadows;

  /// Creates a PersonaData instance from a given path.
  /// The path should point to the directory containing the JSON files.
  factory PersonaData.fromPath(String path) {
    return PersonaData(PersonaConfigReader(path));
  }
}
