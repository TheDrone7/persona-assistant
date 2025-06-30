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
  String toString() {
    return '''
personaData: ${personaData},
screenIndex: ${screenIndex},
scaffoldKey: ${scaffoldKey},
currentScreen: ${currentScreen}
    ''';
  }
}
