import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'navigation.dart';
import '../settings/unlocks.dart';
import 'package:persona_assistant/state/state.dart';

class NavigationHomePage extends StatelessWidget {
  const NavigationHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppState state = Provider.of<AppState>(context);

    return Stack(
      children: [
        Image.asset(
          'assets/images/bg1.jpg',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          key: state.scaffoldKey,
          backgroundColor: Colors.transparent,
          drawer: Observer(
            builder: (_) => Drawer(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg2.jpg'),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                      child: Text(
                        'Persona Assistant',
                        style: Theme.of(context).textTheme.headlineMedium!
                            .copyWith(fontWeight: FontWeight.w400),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Divider(),
                    ),
                    ...destinations.map((dest) {
                      final index = destinations.indexOf(dest);
                      final selected = state.screenIndex == index;
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(4),
                          onTap: () => state.handleMainMenuChange(index),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: selected
                                        ? Theme.of(
                                            context,
                                          ).colorScheme.onSecondary
                                        : Theme.of(context).colorScheme.outline,
                                    width: selected ? 2 : 1,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                  color: selected
                                      ? Theme.of(
                                          context,
                                        ).colorScheme.secondary.withAlpha(250)
                                      : Theme.of(
                                          context,
                                        ).colorScheme.primary.withAlpha(120),
                                ),
                                child: ListTile(
                                  leading: selected
                                      ? dest.selectedIcon
                                      : dest.icon,
                                  title: Text(
                                    dest.label,
                                    style: TextStyle(
                                      fontWeight: selected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                  selected: selected,
                                  selectedColor: Theme.of(
                                    context,
                                  ).colorScheme.onSecondary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
          appBar: AppBar(
            flexibleSpace: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                child: Container(color: Colors.transparent),
              ),
            ),

            leading: IconButton(
              icon: Stack(
                alignment: Alignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.bars,
                    size: 26,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  const FaIcon(FontAwesomeIcons.bars),
                ],
              ),
              onPressed: state.openDrawer,
            ),
            title: Observer(
              builder: (_) => Text(destinations[state.screenIndex].label),
            ),
            actions: [
              IconButton(
                icon: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.gear,
                      size: 26,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    const FaIcon(FontAwesomeIcons.gear),
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UnlockSettingsPage(),
                    ),
                  );
                },
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48.0),
              child: Observer(builder: (_) => state.currentFilters),
            ),
          ),
          body: Observer(
            builder: (_) {
              return state.currentScreen;
            },
          ),
        ),
      ],
    );
  }
}
