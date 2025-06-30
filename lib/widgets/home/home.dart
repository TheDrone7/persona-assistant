// ignore_for_file: prefer_single_quotes

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'navigation.dart';
import 'package:persona_assistant/state/state.dart';

class NavigationHomePage extends StatelessWidget {
  const NavigationHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppState state = Provider.of<AppState>(context);

    return Scaffold(
      key: state.scaffoldKey,
      drawer: Observer(
        builder: (_) => NavigationDrawer(
          onDestinationSelected: state.handleMainMenuChange,
          selectedIndex: state.screenIndex,
          children: [
            Padding(
              padding: EdgeInsetsGeometry.fromLTRB(16, 12, 16, 0),
              child: Text(
                "Persona Assistant",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.fromLTRB(0, 8, 0, 8),
              child: Divider(),
            ),
            ...destinations.map((dest) {
              return NavigationDrawerDestination(
                label: Text(dest.label),
                icon: dest.icon,
                selectedIcon: dest.selectedIcon,
              );
            }),
          ],
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: state.openDrawer,
        ),
        title: Observer(
          builder: (_) => Text(destinations[state.screenIndex].label),
        ),
      ),
      body: Observer(
        builder: (_) {
          return state.currentScreen;
        },
      ),
    );
  }
}
