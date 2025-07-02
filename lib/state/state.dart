import 'package:mobx/mobx.dart';
import 'package:persona_assistant/types/extensions.dart';
import 'package:persona_data/lib.dart';
import 'package:flutter/material.dart';

import 'package:persona_assistant/types/filters.dart';
import 'package:persona_assistant/constants/sort_options.dart';
import 'package:persona_assistant/constants/filter_options.dart';

// Pages
import '../widgets/skills/list.dart';
import '../widgets/personas/list.dart';
import '../widgets/shadows/list.dart';
import '../widgets/personas/filters.dart';
import '../widgets/skills/filters.dart';
import '../widgets/shadows/filters.dart';

part 'state.g.dart';

class AppState extends _AppState with _$AppState {}

abstract class _AppState with Store {
  @observable
  PersonaData personaData = PersonaData('assets/p3r/jsons/');

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
      case 2:
        return ShadowFilters();
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
    if (skillFilter.value != 'all') {
      // Check if the filter is a combat element
      final isCombat = CombatElement.values.any(
        (e) => e.name.toLowerCase() == skillFilter.value.toLowerCase(),
      );

      if (isCombat) {
        skills = skills
            .where(
              (s) =>
                  s.element.name.toLowerCase() == skillFilter.value &&
                  s.type == SkillType.attack,
            )
            .toList();
      } else {
        skills = skills
            .where((s) => s.type.name.toLowerCase() == skillFilter.value)
            .toList();
      }
    }

    // Apply sort order
    switch (skillSortOrder.value) {
      case 'name_asc':
        skills.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'name_desc':
        skills.sort((a, b) => b.name.compareTo(a.name));
        break;
      case 'cost_asc':
        skills.sort((a, b) {
          final aType = a.costType.index == 3 ? -1 : a.costType.index;
          final bType = b.costType.index == 3 ? -1 : b.costType.index;
          return bType.compareTo(aType) != 0
              ? bType.compareTo(aType)
              : a.cost.compareTo(b.cost);
        });
        break;
      case 'cost_desc':
        skills.sort(
          (a, b) => a.costType.index.compareTo(b.costType.index) != 0
              ? a.costType.index.compareTo(b.costType.index)
              : b.cost.compareTo(a.cost),
        );
        break;
      case 'rank_asc':
        skills.sort(
          (a, b) => (a.rank == 0 ? (-1 >>> 1) : a.rank).compareTo(
            (b.rank == 0 ? (-1 >>> 1) : b.rank),
          ),
        );
        break;
      case 'rank_desc':
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

  @computed
  List<PersonaShadow> get filteredShadows {
    List<PersonaShadow> shadows = personaData.shadows.values.toList();

    // Apply shadow filter
    if (shadowFilter.value != 'all' && shadowFilter.value != 'boss') {
      shadows = shadows
          .where(
            (s) =>
                s.areaEncountered.toLowerCase().startsWith(shadowFilter.value),
          )
          .toList();
    } else if (shadowFilter.value == 'boss') {
      shadows = shadows.where((s) => s.isBoss).toList();
    }

    // Apply sort order
    switch (shadowSortOrder.value) {
      case 'level_desc':
        shadows.sort(
          (a, b) => b.level.compareTo(a.level) != 0
              ? b.level.compareTo(a.level)
              : a.name.compareTo(b.name),
        );
        break;
      case 'name_asc':
        shadows.sort(
          (a, b) => a.name.compareTo(b.name) != 0
              ? a.name.compareTo(b.name)
              : a.level.compareTo(b.level),
        );
        break;
      case 'name_desc':
        shadows.sort(
          (a, b) => b.name.compareTo(a.name) != 0
              ? b.name.compareTo(a.name)
              : a.level.compareTo(b.level),
        );
        break;
      case 'arcana':
        shadows.sort((a, b) {
          final aArcana = personaData.arcana.indexWhere(
            (arc) => arc.toLowerCase() == a.arcana.toLowerCase(),
          );
          final bArcana = personaData.arcana.indexWhere(
            (arc) => arc.toLowerCase() == b.arcana.toLowerCase(),
          );
          if (aArcana != bArcana) {
            return aArcana.compareTo(bArcana);
          }
          if (a.level != b.level) {
            return a.level.compareTo(b.level);
          }
          if (a.name != b.name) {
            return a.name.compareTo(b.name);
          }
          return 0; // If all are equal, maintain original order
        });
        break;
      default:
        shadows.sort(
          (a, b) => a.level.compareTo(b.level) != 0
              ? a.level.compareTo(b.level)
              : a.name.compareTo(b.name),
        );
        break;
    }

    return shadows;
  }
}
