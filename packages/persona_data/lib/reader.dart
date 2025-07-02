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
  PersonaConfigReader(this.dirPath);

  Future<void> loadConfig() async {
    try {
      final String personaJson = await rootBundle.loadString(
        '${rootDir}demon-data.json',
      );
      _personaData.clear();
      _personaData.addAll(jsonDecode(personaJson));

      final String unlockJson = await rootBundle.loadString(
        '${rootDir}demon-unlocks.json',
      );
      _unlockData.clear();
      _unlockData.addAll(jsonDecode(unlockJson));

      final String enemyJson = await rootBundle.loadString(
        '${rootDir}enemy-data.json',
      );
      _enemyData.clear();
      _enemyData.addAll(jsonDecode(enemyJson));

      final String fusionJson = await rootBundle.loadString(
        '${rootDir}fusion-chart.json',
      );
      _fusionData.clear();
      _fusionData.addAll(jsonDecode(fusionJson));

      final String partyJson = await rootBundle.loadString(
        '${rootDir}party-data.json',
      );
      _partyData.clear();
      _partyData.addAll(jsonDecode(partyJson));

      final String skillJson = await rootBundle.loadString(
        '${rootDir}skill-data.json',
      );
      _skillData.clear();
      _skillData.addAll(jsonDecode(skillJson));

      final String specialJson = await rootBundle.loadString(
        '${rootDir}special-recipes.json',
      );
      _specialData.clear();
      _specialData.addAll(jsonDecode(specialJson));
    } catch (e) {
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
}
