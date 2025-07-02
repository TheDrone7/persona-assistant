import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class PersonaConfigReader {
  final String dirPath;
  final Map<String, dynamic> _personaData = {};
  final List<dynamic> _unlockData = [];
  final Map<String, dynamic> _enemyData = {};
  final Map<String, dynamic> _fusionData = {};
  final Map<String, dynamic> _partyData = {};
  final Map<String, dynamic> _skillData = {};
  final Map<String, dynamic> _specialData = {};
  bool _isLoaded = false;
  PersonaConfigReader(this.dirPath);

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

  get rootDir => dirPath.endsWith('/') ? dirPath : '$dirPath/';
  get personaData => _personaData;
  get unlockData => _unlockData;
  get enemyData => _enemyData;
  get fusionData => _fusionData;
  get partyData => _partyData;
  get skillData => _skillData;
  get specialData => _specialData;
  get isReady => _isLoaded;
}
