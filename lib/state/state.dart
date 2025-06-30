import 'package:mobx/mobx.dart';
import 'package:persona_data/lib.dart';
import 'package:flutter/material.dart';

// Pages
import '../widgets/skills/list.dart';
import '../widgets/personas/list.dart';
import '../widgets/shadows/list.dart';

part 'state.g.dart';

class AppState extends _AppState with _$AppState {}

abstract class _AppState with Store {
  @observable
  PersonaData personaData = PersonaData();

  @observable
  int screenIndex = 0;

  @observable
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @action
  void setScreenIndex(int index) {
    screenIndex = index;
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
}
