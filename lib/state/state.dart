import 'package:mobx/mobx.dart';
import 'package:persona_data/lib.dart';
import 'package:flutter/material.dart';

// Pages
import '../widgets/skills/list.dart';
import '../widgets/personas/list.dart';
import '../widgets/shadows/list.dart';
import '../widgets/personas/filters.dart';

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
  String personaArcanaFilter = 'All';
  @observable
  String personaSortOrder = 'default';

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
  void setPersonaArcanaFilter(String filter) {
    personaArcanaFilter = filter;
  }

  @action
  void setPersonaSortOrder(String order) {
    personaSortOrder = order;
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
      default:
        return SizedBox.shrink(); // No filters for other screens
    }
  }
}
