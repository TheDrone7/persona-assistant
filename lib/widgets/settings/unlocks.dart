import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p3r_data/lib.dart';

import 'category.dart';

/// The settings page for unlocking personas by method.
class UnlockSettingsPage extends StatelessWidget {
  /// Creates an [UnlockSettingsPage].
  const UnlockSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/bg1.jpg',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: Container(color: Colors.transparent),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            flexibleSpace: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                child: Container(color: Colors.transparent),
              ),
            ),
            title: const Text('Persona Settings'),
            leading: IconButton(
              icon: const FaIcon(FontAwesomeIcons.xmark),
              onPressed: () =>
                  Navigator.of(context).popUntil((Route r) => r.isFirst),
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).listTileTheme.tileColor?.withAlpha(100),
            ),
            child: ListView(
              children: [
                ...PersonaUnlockMethod.values
                    .where(
                      (method) =>
                          method != PersonaUnlockMethod.level &&
                          method != PersonaUnlockMethod.locked,
                    )
                    .map(
                      (method) =>
                          UnlockSettingsCategory(representedMethod: method),
                    ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
