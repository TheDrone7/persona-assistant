import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persona_data/lib.dart';

import 'category.dart';

/// The settings page for unlocking personas by method.
class UnlockSettingsPage extends StatelessWidget {
  /// Creates an [UnlockSettingsPage].
  const UnlockSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                  (method) => UnlockSettingsCategory(representedMethod: method),
                ),
          ],
        ),
      ),
    );
  }
}
