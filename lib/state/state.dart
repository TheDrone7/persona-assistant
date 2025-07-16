import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:p3r_data/lib.dart';

import '../types/filters.dart';
import '../constants/filter_options.dart';
import '../constants/sort_options.dart';

// Sorts
import '../utilities/persona_sort.dart';
import '../utilities/skill_sort.dart';
import '../utilities/shadow_sort.dart';

// Pages
import '../widgets/personas/list.dart';
import '../widgets/shadows/list.dart';
import '../widgets/skills/list.dart';

// Filters
import '../widgets/personas/filters.dart';
import '../widgets/shadows/filters.dart';
import '../widgets/skills/filters.dart';

part 'state.g.dart';

class AppState extends _AppState with _$AppState {}

abstract class _AppState with Store {
  @observable
  PersonaData personaData = PersonaData.fromPath('assets/p3r/jsons/');

  @observable
  int screenIndex = 0;
  @observable
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @observable
  String searchQuery = '';
  @observable
  FilterOption personaArcanaFilter = personaFilterOptions.first;
  @observable
  SortOption personaSortOrder = personaSortOptions.first;

  @observable
  SortOption skillSortOrder = skillSortOptions.first;
  @observable
  FilterOption skillFilter = skillFilterOptions.first;

  @observable
  SortOption shadowSortOrder = shadowSortOptions.first;
  @observable
  FilterOption shadowFilter = shadowFilterOptions.first;

  @observable
  ObservableMap<String, bool> personaUnlocks = ObservableMap.of({});

  ReactionDisposer? _personaUnlocksReaction;

  @action
  void setScreenIndex(int index) {
    screenIndex = index;
  }

  @action
  Future<void> initialize() async {
    await personaData.initialize(null);

    // Initialize persona unlocks
    personaUnlocks = ObservableMap.of(personaData.personaUnlocked);

    if (_personaUnlocksReaction != null) {
      _personaUnlocksReaction!();
    }
    syncUnlocks();

    // Load saved unlocks from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    for (final persona in personaData.unlockablePersonas.keys) {
      final key = 'persona_unlock_$persona';

      // If the key doesn't exist, use the default values
      final unlocked = prefs.getBool(key) ?? personaUnlocks[persona] ?? true;
      // Save the unlock state to the observable map
      personaUnlocks[persona] = unlocked;
    }
  }

  @action
  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  @action
  void handleMainMenuChange(int index) {
    setScreenIndex(index);
    if (scaffoldKey.currentState!.isDrawerOpen) {
      scaffoldKey.currentState!.closeDrawer();
    }
  }

  @action
  void setPersonaArcanaFilter(FilterOption filter) {
    personaArcanaFilter = filter;
  }

  @action
  void setPersonaSortOrder(String order) {
    personaSortOrder = personaSortOptions.firstWhere(
      (option) => option.value.toLowerCase() == order.toLowerCase(),
      orElse: () => personaSortOptions.first,
    );
  }

  @action
  void setSkillSortOrder(SortOption order) {
    skillSortOrder = order;
  }

  @action
  void setSkillFilter(FilterOption filter) {
    skillFilter = filter;
  }

  @action
  void setShadowSortOrder(SortOption order) {
    shadowSortOrder = order;
  }

  @action
  void setShadowFilter(FilterOption filter) {
    shadowFilter = filter;
  }

  @action
  Future<void> setPersonaUnlock(String personaName, bool unlocked) async {
    if (personaUnlocks.containsKey(personaName)) {
      final prefs = await SharedPreferences.getInstance();
      final key = 'persona_unlock_$personaName';
      personaUnlocks[personaName] = unlocked;
      // Save the unlock state to SharedPreferences
      await prefs.setBool(key, unlocked);
    } else {
      throw ArgumentError('Persona $personaName not found in data.');
    }
  }

  void syncUnlocks() {
    _personaUnlocksReaction = autorun((_) {
      for (final entry in personaUnlocks.entries) {
        final String personaName = entry.key;
        final bool unlocked = entry.value;

        if (personaData.personaUnlocked.containsKey(personaName)) {
          personaData.setPersonaUnlocked(personaName, unlocked);
        } else {
          throw ArgumentError('Persona $personaName not found in data.');
        }
      }
    });
  }

  @computed
  Widget get currentScreen {
    switch (screenIndex) {
      case 0:
        return PersonaListPage();
      case 1:
        return SkillsPage();
      case 2:
        return ShadowsListPage();
      default:
        throw UnsupportedError('Invalid screen index: $screenIndex');
    }
  }

  @computed
  Widget get currentFilters {
    switch (screenIndex) {
      case 0:
        return PersonaFilters();
      case 1:
        return PersonaSkillFilters();
      case 2:
        return ShadowFilters();
      default:
        return SizedBox.shrink(); // No filters for other screens
    }
  }

  @computed
  List<Persona> get filteredPersonas {
    List<Persona> personas = personaData.personas.values.toList();

    personas = filterPersonas(personas, personaArcanaFilter, personaUnlocks);
    personas = sortPersonas(personas, personaSortOrder.value);

    return personas;
  }

  @computed
  List<PersonaSkill> get filteredSkills {
    List<PersonaSkill> skills = personaData.skills.values
        .where((skill) => !skill.isUnique)
        .toList();

    skills = filterSkills(skills, skillFilter);
    skills = sortSkills(skills, skillSortOrder.value);

    return skills;
  }

  @computed
  List<PersonaShadow> get filteredShadows {
    List<PersonaShadow> shadows = personaData.shadows.values.toList();

    shadows = filterShadows(shadows, shadowFilter);
    shadows = sortShadows(shadows, shadowSortOrder.value);

    return shadows;
  }
}
