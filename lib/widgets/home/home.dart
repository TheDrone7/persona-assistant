import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../constants/navigation.dart';
import '../../state/state.dart';
import '../common/outlined_icon.dart';
import '../settings/unlocks.dart';

import 'navigation_drawer_item.dart';
import 'package:p3r_data/lib.dart';

/// The main home page widget with navigation drawer, app bar, and dynamic content.
class NavigationHomePage extends StatelessWidget {
  const NavigationHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Precache all Arcana images
    for (final arcana in Arcana.values) {
      precacheImage(AssetImage('assets/p3r/${arcana.imagePath}'), context);
    }
    // Precache all CombatElement images
    for (final element in CombatElement.values) {
      precacheImage(AssetImage('assets/p3r/${element.imagePath}'), context);
    }
    // Precache all InheritanceElement images
    for (final element in InheritanceElement.values) {
      precacheImage(AssetImage('assets/p3r/${element.imagePath}'), context);
    }
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
          drawer: Observer(builder: (_) => _NavigationDrawer(state: state)),
          appBar: AppBar(
            flexibleSpace: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                child: Container(color: Colors.transparent),
              ),
            ),
            leading: IconButton(
              icon: const OutlinedIcon(icon: FontAwesomeIcons.bars),
              onPressed: state.openDrawer,
            ),
            title: Observer(
              builder: (_) => Text(destinations[state.screenIndex].label),
            ),
            actions: [
              IconButton(
                icon: const OutlinedIcon(icon: FontAwesomeIcons.gear),
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

/// Drawer widget for navigation, extracted from NavigationHomePage for clarity.
class _NavigationDrawer extends StatelessWidget {
  final AppState state;
  const _NavigationDrawer({required this.state});

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: Divider(),
            ),
            ...destinations.map((dest) {
              final index = destinations.indexOf(dest);
              final selected = state.screenIndex == index;
              return NavigationDrawerItem(
                selected: selected,
                onTap: () => state.handleMainMenuChange(index),
                icon: dest.icon,
                selectedIcon: dest.selectedIcon,
                label: dest.label,
              );
            }),
          ],
        ),
      ),
    );
  }
}
