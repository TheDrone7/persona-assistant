import 'package:mobx/mobx.dart';
import 'package:persona_assistant/types/extensions.dart';
import 'package:persona_data/lib.dart';
import 'package:flutter/material.dart';

import 'package:persona_assistant/types/filters.dart';
import 'package:persona_assistant/constants/sort_options.dart';
import 'package:persona_assistant/constants/filter_choices.dart';

// Pages
import '../widgets/skills/list.dart';
import '../widgets/personas/list.dart';
import '../widgets/shadows/list.dart';
import '../widgets/personas/filters.dart';
import '../widgets/skills/filters.dart';

part 'state.g.dart';

class AppState extends _AppState with _$AppState {}

abstract class _AppState with Store {
  @observable
  PersonaData personaData = PersonaData();

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
  String skillSortOrder = 'default';
  @observable
  String skillFilter = 'all';

  @action
  void setScreenIndex(int index) {
    screenIndex = index;
  }

  @action
  Future<void> initialize() async {
    await personaData.loadSkills();
    await personaData.loadPersonas();
    await personaData.loadShadows();
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
  void setSkillSortOrder(String order) {
    skillSortOrder = order;
  }

  @action
  void setSkillFilter(String filter) {
    skillFilter = filter;
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
      case 3:
        return Center(child: Text('Recipe Generator'));
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
      default:
        return SizedBox.shrink(); // No filters for other screens
    }
  }

  @computed
  List<Persona> get filteredPersonas {
    List<Persona> personas = personaData.personas.values.toList();

    // Apply arcana filter
    if (personaArcanaFilter.value != 'all') {
      personas = personas
          .where((p) => p.arcana == personaArcanaFilter.value.capitalize())
          .toList();
    }

    // Apply sort order
    switch (personaSortOrder.value) {
      case 'level_asc':
        personas.sort((a, b) => a.level.compareTo(b.level));
        break;
      case 'level_desc':
        personas.sort((a, b) => b.level.compareTo(a.level));
        break;
      case 'name_asc':
        personas.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'name_desc':
        personas.sort((a, b) => b.name.compareTo(a.name));
        break;
      default:
        personas.sort(
          (a, b) =>
              (personaData.arcana.indexOf(a.arcana) -
                      personaData.arcana.indexOf(b.arcana)) !=
                  0
              ? personaData.arcana.indexOf(a.arcana) -
                    personaData.arcana.indexOf(b.arcana)
              : (a.unlockMethod.index - b.unlockMethod.index) != 0
              ? a.unlockMethod.index - b.unlockMethod.index
              : (a.level - b.level) != 0
              ? a.level - b.level
              : a.name.compareTo(b.name),
        );
        break;
    }

    return personas;
  }

  @computed
  List<PersonaSkill> get filteredSkills {
    List<PersonaSkill> skills = personaData.skills.values.toList();

    // Apply skill filter
    if (skillFilter != 'all') {
      skills = skills
          .where(
            (s) =>
                s.type.name.toLowerCase() == skillFilter ||
                s.element.name.toLowerCase() == skillFilter,
          )
          .toList();
    }

    // Apply sort order
    switch (skillSortOrder) {
      case 'name (a - z)':
        skills.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'name (z - a)':
        skills.sort((a, b) => b.name.compareTo(a.name));
        break;
      case 'cost (△)':
        skills.sort((a, b) => a.cost.compareTo(b.cost));
        break;
      case 'cost (▽)':
        skills.sort(
          (a, b) => a.costType.index.compareTo(b.costType.index) != 0
              ? a.costType.index.compareTo(b.costType.index)
              : b.cost.compareTo(a.cost),
        );
        break;
      case 'rank (▽)':
        skills.sort((a, b) => a.rank.compareTo(b.rank));
        break;
      case 'rank (△)':
        skills.sort((a, b) => b.rank.compareTo(a.rank));
        break;
      default:
        skills.sort(
          (a, b) => a.element.index.compareTo(b.element.index) != 0
              ? a.element.index.compareTo(b.element.index)
              : a.name.compareTo(b.name),
        );
        break;
    }

    return skills;
  }
}
