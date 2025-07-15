import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

/// Reads the Persona data from the JSON files.
class PersonaConfigReader {
  /// The path to the directory containing the JSON files.
  final String dirPath;

  /// The data for the personas.
  final Map<String, dynamic> _personaData = {};

  /// The data for the unlockable personas.
  final List<dynamic> _unlockData = [];

  /// The data for the enemies.
  final Map<String, dynamic> _enemyData = {};

  /// The data for the fusion chart.
  final Map<String, dynamic> _fusionData = {};

  /// The data for the party.
  final Map<String, dynamic> _partyData = {};

  /// The data for the skills.
  final Map<String, dynamic> _skillData = {};

  /// The data for the special recipes.
  final Map<String, dynamic> _specialData = {};

  /// Whether the data has been loaded.
  bool _isLoaded = false;

  /// Creates a new PersonaConfigReader.
  ///
  /// [dirPath] The path to the directory containing the JSON files.
  PersonaConfigReader(this.dirPath);

  /// Loads the Persona data from the JSON files.
  Future<void> loadConfig() async {
    try {
      final String personaString = await rootBundle.loadString(
        '${rootDir}demon-data.json',
      );
      final Map<String, dynamic> personaJson = jsonDecode(personaString);
      if (personaJson.isEmpty) {
        throw Exception('Persona data is empty');
      }
      _personaData.clear();
      _personaData.addAll(personaJson); // DONE

      final String unlockString = await rootBundle.loadString(
        '${rootDir}demon-unlocks.json',
      );
      final List<dynamic> unlockJson = jsonDecode(unlockString);
      if (unlockJson.isEmpty) {
        throw Exception('Unlock data is empty');
      }
      _unlockData.clear();
      _unlockData.addAll(unlockJson); // DONE

      final String enemyString = await rootBundle.loadString(
        '${rootDir}enemy-data.json',
      );
      final Map<String, dynamic> enemyJson = jsonDecode(enemyString);
      if (enemyJson.isEmpty) {
        throw Exception('Enemy data is empty');
      }
      _enemyData.clear();
      _enemyData.addAll(enemyJson); // DONE

      final String fusionString = await rootBundle.loadString(
        '${rootDir}fusion-chart.json',
      );
      final Map<String, dynamic> fusionJson = jsonDecode(fusionString);
      if (fusionJson.isEmpty) {
        throw Exception('Fusion chart is empty');
      }
      _fusionData.clear();
      _fusionData.addAll(fusionJson); // DONE

      final String partyString = await rootBundle.loadString(
        '${rootDir}party-data.json',
      );
      final Map<String, dynamic> partyJson = jsonDecode(partyString);
      if (partyJson.isEmpty) {
        throw Exception('Party data is empty');
      }
      _partyData.clear();
      _partyData.addAll(partyJson); // DONE

      final String skillString = await rootBundle.loadString(
        '${rootDir}skill-data.json',
      );
      final Map<String, dynamic> skillJson = jsonDecode(skillString);
      if (skillJson.isEmpty) {
        throw Exception('Skill data is empty');
      }
      _skillData.clear();
      _skillData.addAll(skillJson); // DONE

      final String specialString = await rootBundle.loadString(
        '${rootDir}special-recipes.json',
      );
      final Map<String, dynamic> specialJson = jsonDecode(specialString);
      if (specialJson.isEmpty) {
        throw Exception('Special recipes data is empty');
      }
      _specialData.clear();
      _specialData.addAll(specialJson); // DONE

      _isLoaded = true; // ALL DONE
    } catch (e) {
      _isLoaded = false;
      throw Exception('Failed to load Persona config: $e');
    }
  }

  /// The root directory of the JSON files.
  String get rootDir => dirPath.endsWith('/') ? dirPath : '$dirPath/';

  /// The data for the personas.
  Map<String, dynamic> get personaData => _personaData;

  /// The data for the unlockable personas.
  List<dynamic> get unlockData => _unlockData;

  /// The data for the enemies.
  Map<String, dynamic> get enemyData => _enemyData;

  /// The data for the fusion chart.
  Map<String, dynamic> get fusionData => _fusionData;

  /// The data for the party.
  Map<String, dynamic> get partyData => _partyData;

  /// The data for the skills.
  Map<String, dynamic> get skillData => _skillData;

  /// The data for the special recipes.
  Map<String, dynamic> get specialData => _specialData;

  /// Whether the data has been loaded.
  bool get isReady => _isLoaded;
}
