// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: ...


part of 'state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppState on _AppState, Store {
  Computed<Widget>? _$currentScreenComputed;

  @override
  Widget get currentScreen => (_$currentScreenComputed ??= Computed<Widget>(
    () => super.currentScreen,
    name: '_AppState.currentScreen',
  )).value;
  Computed<Widget>? _$currentFiltersComputed;

  @override
  Widget get currentFilters => (_$currentFiltersComputed ??= Computed<Widget>(
    () => super.currentFilters,
    name: '_AppState.currentFilters',
  )).value;
  Computed<List<Persona>>? _$filteredPersonasComputed;

  @override
  List<Persona> get filteredPersonas =>
      (_$filteredPersonasComputed ??= Computed<List<Persona>>(
        () => super.filteredPersonas,
        name: '_AppState.filteredPersonas',
      )).value;
  Computed<List<PersonaSkill>>? _$filteredSkillsComputed;

  @override
  List<PersonaSkill> get filteredSkills =>
      (_$filteredSkillsComputed ??= Computed<List<PersonaSkill>>(
        () => super.filteredSkills,
        name: '_AppState.filteredSkills',
      )).value;
  Computed<List<PersonaShadow>>? _$filteredShadowsComputed;

  @override
  List<PersonaShadow> get filteredShadows =>
      (_$filteredShadowsComputed ??= Computed<List<PersonaShadow>>(
        () => super.filteredShadows,
        name: '_AppState.filteredShadows',
      )).value;

  late final _$personaDataAtom = Atom(
    name: '_AppState.personaData',
    context: context,
  );

  @override
  PersonaData get personaData {
    _$personaDataAtom.reportRead();
    return super.personaData;
  }

  @override
  set personaData(PersonaData value) {
    _$personaDataAtom.reportWrite(value, super.personaData, () {
      super.personaData = value;
    });
  }

  late final _$screenIndexAtom = Atom(
    name: '_AppState.screenIndex',
    context: context,
  );

  @override
  int get screenIndex {
    _$screenIndexAtom.reportRead();
    return super.screenIndex;
  }

  @override
  set screenIndex(int value) {
    _$screenIndexAtom.reportWrite(value, super.screenIndex, () {
      super.screenIndex = value;
    });
  }

  late final _$scaffoldKeyAtom = Atom(
    name: '_AppState.scaffoldKey',
    context: context,
  );

  @override
  GlobalKey<ScaffoldState> get scaffoldKey {
    _$scaffoldKeyAtom.reportRead();
    return super.scaffoldKey;
  }

  @override
  set scaffoldKey(GlobalKey<ScaffoldState> value) {
    _$scaffoldKeyAtom.reportWrite(value, super.scaffoldKey, () {
      super.scaffoldKey = value;
    });
  }

  late final _$searchQueryAtom = Atom(
    name: '_AppState.searchQuery',
    context: context,
  );

  @override
  String get searchQuery {
    _$searchQueryAtom.reportRead();
    return super.searchQuery;
  }

  @override
  set searchQuery(String value) {
    _$searchQueryAtom.reportWrite(value, super.searchQuery, () {
      super.searchQuery = value;
    });
  }

  late final _$personaArcanaFilterAtom = Atom(
    name: '_AppState.personaArcanaFilter',
    context: context,
  );

  @override
  FilterOption get personaArcanaFilter {
    _$personaArcanaFilterAtom.reportRead();
    return super.personaArcanaFilter;
  }

  @override
  set personaArcanaFilter(FilterOption value) {
    _$personaArcanaFilterAtom.reportWrite(value, super.personaArcanaFilter, () {
      super.personaArcanaFilter = value;
    });
  }

  late final _$personaSortOrderAtom = Atom(
    name: '_AppState.personaSortOrder',
    context: context,
  );

  @override
  SortOption get personaSortOrder {
    _$personaSortOrderAtom.reportRead();
    return super.personaSortOrder;
  }

  @override
  set personaSortOrder(SortOption value) {
    _$personaSortOrderAtom.reportWrite(value, super.personaSortOrder, () {
      super.personaSortOrder = value;
    });
  }

  late final _$skillSortOrderAtom = Atom(
    name: '_AppState.skillSortOrder',
    context: context,
  );

  @override
  SortOption get skillSortOrder {
    _$skillSortOrderAtom.reportRead();
    return super.skillSortOrder;
  }

  @override
  set skillSortOrder(SortOption value) {
    _$skillSortOrderAtom.reportWrite(value, super.skillSortOrder, () {
      super.skillSortOrder = value;
    });
  }

  late final _$skillFilterAtom = Atom(
    name: '_AppState.skillFilter',
    context: context,
  );

  @override
  FilterOption get skillFilter {
    _$skillFilterAtom.reportRead();
    return super.skillFilter;
  }

  @override
  set skillFilter(FilterOption value) {
    _$skillFilterAtom.reportWrite(value, super.skillFilter, () {
      super.skillFilter = value;
    });
  }

  late final _$shadowSortOrderAtom = Atom(
    name: '_AppState.shadowSortOrder',
    context: context,
  );

  @override
  SortOption get shadowSortOrder {
    _$shadowSortOrderAtom.reportRead();
    return super.shadowSortOrder;
  }

  @override
  set shadowSortOrder(SortOption value) {
    _$shadowSortOrderAtom.reportWrite(value, super.shadowSortOrder, () {
      super.shadowSortOrder = value;
    });
  }

  late final _$shadowFilterAtom = Atom(
    name: '_AppState.shadowFilter',
    context: context,
  );

  @override
  FilterOption get shadowFilter {
    _$shadowFilterAtom.reportRead();
    return super.shadowFilter;
  }

  @override
  set shadowFilter(FilterOption value) {
    _$shadowFilterAtom.reportWrite(value, super.shadowFilter, () {
      super.shadowFilter = value;
    });
  }

  late final _$initializeAsyncAction = AsyncAction(
    '_AppState.initialize',
    context: context,
  );

  @override
  Future<void> initialize() {
    return _$initializeAsyncAction.run(() => super.initialize());
  }

  late final _$_AppStateActionController = ActionController(
    name: '_AppState',
    context: context,
  );

  @override
  void setScreenIndex(int index) {
    final _$actionInfo = _$_AppStateActionController.startAction(
      name: '_AppState.setScreenIndex',
    );
    try {
      return super.setScreenIndex(index);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void openDrawer() {
    final _$actionInfo = _$_AppStateActionController.startAction(
      name: '_AppState.openDrawer',
    );
    try {
      return super.openDrawer();
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void handleMainMenuChange(int index) {
    final _$actionInfo = _$_AppStateActionController.startAction(
      name: '_AppState.handleMainMenuChange',
    );
    try {
      return super.handleMainMenuChange(index);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPersonaArcanaFilter(FilterOption filter) {
    final _$actionInfo = _$_AppStateActionController.startAction(
      name: '_AppState.setPersonaArcanaFilter',
    );
    try {
      return super.setPersonaArcanaFilter(filter);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPersonaSortOrder(String order) {
    final _$actionInfo = _$_AppStateActionController.startAction(
      name: '_AppState.setPersonaSortOrder',
    );
    try {
      return super.setPersonaSortOrder(order);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSkillSortOrder(SortOption order) {
    final _$actionInfo = _$_AppStateActionController.startAction(
      name: '_AppState.setSkillSortOrder',
    );
    try {
      return super.setSkillSortOrder(order);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSkillFilter(FilterOption filter) {
    final _$actionInfo = _$_AppStateActionController.startAction(
      name: '_AppState.setSkillFilter',
    );
    try {
      return super.setSkillFilter(filter);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setShadowSortOrder(SortOption order) {
    final _$actionInfo = _$_AppStateActionController.startAction(
      name: '_AppState.setShadowSortOrder',
    );
    try {
      return super.setShadowSortOrder(order);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setShadowFilter(FilterOption filter) {
    final _$actionInfo = _$_AppStateActionController.startAction(
      name: '_AppState.setShadowFilter',
    );
    try {
      return super.setShadowFilter(filter);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
personaData: ${personaData},
screenIndex: ${screenIndex},
scaffoldKey: ${scaffoldKey},
searchQuery: ${searchQuery},
personaArcanaFilter: ${personaArcanaFilter},
personaSortOrder: ${personaSortOrder},
skillSortOrder: ${skillSortOrder},
skillFilter: ${skillFilter},
shadowSortOrder: ${shadowSortOrder},
shadowFilter: ${shadowFilter},
currentScreen: ${currentScreen},
currentFilters: ${currentFilters},
filteredPersonas: ${filteredPersonas},
filteredSkills: ${filteredSkills},
filteredShadows: ${filteredShadows}
    ''';
  }
}
