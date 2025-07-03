import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persona_data/lib.dart';

import 'category.dart';

class UnlockSettingsPage extends StatelessWidget {
  const UnlockSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Persona Settings'),
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.xmark),
          onPressed: () =>
              Navigator.of(context).popUntil((Route r) => r.isFirst),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Text(
            'Select unlocked personas',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          SizedBox(height: 8.0),
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
    );
  }
}
