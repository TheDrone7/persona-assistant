import 'dart:async' show Future;
import 'package:flutter/foundation.dart';

import 'types/persona.dart';
import 'types/shadow.dart';
import 'types/skill.dart';

import 'fusion.dart';
import 'reader.dart';

/// The base class for managing all Persona data.
class PersonaData {
  /// The configuration reader used to load data from JSON files.
  final PersonaConfigReader reader;

  /// Creates a new PersonaData instance with the specified reader.
  PersonaData(this.reader);

  /// Internal map storing all loaded skills by their names.
  final Map<String, PersonaSkill> _skills = {};

  /// Internal map storing all loaded personas by their names.
  final Map<String, Persona> _personas = {};

  /// Internal map storing all loaded shadows by their names.
  final Map<String, PersonaShadow> _shadows = {};

  /// Internal map tracking the unlock status of each persona.
  final Map<String, bool> _personaUnlocked = {};

  /// Internal map storing the default unlock status for each persona.
  final Map<String, bool> _defaultUnlocked = {};

  /// The fusion calculator instance used for persona fusion operations.
  final FusionCalculator fusionCalculator = FusionCalculator();

  /// Loads and processes all skill data from JSON files, creating PersonaSkill objects.
  /// Clears existing skills before loading new ones.
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

  /// Loads and processes all shadow data from JSON files, creating PersonaShadow objects.
  /// Ensures skills are loaded first since shadows may reference skills.
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
  ///
  /// Sources:
  /// - `jsons/demon-data.json` (Base persona data)
  /// - `jsons/demon-unlocks.json` (Unlock conditions)
  /// - `jsons/party-data.json` (Party personas)
  ///
  /// Processes unlock methods and conditions, creates Persona objects,
  /// and establishes relationships between personas and their skills.
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
  ///
  /// [name] The name of the persona to update.
  /// [unlocked] Whether the persona should be unlocked (true) or locked (false).
  ///
  /// Returns true if the persona was found and updated, false otherwise.
  bool setPersonaUnlocked(String name, bool unlocked) {
    if (_personas.containsKey(name)) {
      _personaUnlocked[name] = unlocked;
      if (unlocked) {
        fusionCalculator.addPersona(_personas[name]!);
        for (var skillName in _personas[name]!.skills.keys) {
          final skill = _skills[skillName];
          if (skill != null) {
            skill.addPersona(name, _personas[name]!.skills[skillName]!);
          }
        }
      } else {
        fusionCalculator.removePersona(_personas[name]!);
        for (var skillName in _personas[name]!.skills.keys) {
          final skill = _skills[skillName];
          if (skill != null) {
            skill.removePersona(name);
          }
        }
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
  ///
  /// Loads configuration, skills, personas, shadows, initializes fusion calculator,
  /// and sets initial unlock status for all personas.
  ///
  /// [unlocks] Optional map of persona names to their unlock status.
  ///           If not provided, uses default unlock status from data files.
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

  /// Returns a map where keys are skill names and values are PersonaSkill objects.
  Map<String, PersonaSkill> get skills => _skills;

  /// Returns a map where keys are persona names and values are boolean
  /// indicating whether the persona is currently unlocked.
  Map<String, bool> get personaUnlocked => _personaUnlocked;

  /// Returns personas that can have their unlock status changed by the user.
  /// Excludes locked personas (party members) and level-progression personas.
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

  /// Returns all personas currently available for use.
  /// Filters out locked personas.
  Map<String, Persona> get personas {
    final Map<String, Persona> unlockedPersonas = {};
    _personas.forEach((key, persona) {
      if (_personaUnlocked[key] ?? true) {
        unlockedPersonas[key] = persona;
      }
    });
    return unlockedPersonas;
  }

  ///
  /// Returns a map where keys are shadow names and values are PersonaShadow objects.
  Map<String, PersonaShadow> get shadows => _shadows;

  /// Gets a persona by its exact name from the internal data.
  ///
  /// [name] The exact name of the persona to retrieve.
  Persona? getPersonaByName(String name) {
    return _personas[name];
  }

  /// Gets a skill by its exact name from the internal data.
  ///
  /// [name] The exact name of the skill to retrieve.
  PersonaSkill? getSkillByName(String name) {
    return _skills[name];
  }

  /// Gets a shadow by its exact name from the internal data.
  ///
  /// [name] The exact name of the shadow to retrieve.
  PersonaShadow? getShadowByName(String name) {
    return _shadows[name];
  }

  /// Creates a PersonaData instance from a given path.
  ///
  /// [path] The path to the directory containing the JSON files.
  ///
  /// Returns a new PersonaData instance ready for initialization.
  factory PersonaData.fromPath(String path) {
    return PersonaData(PersonaConfigReader(path));
  }
}
