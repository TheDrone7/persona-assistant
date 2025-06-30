import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:persona_assistant/state/state.dart';

import 'persona.dart';

class PersonaListPage extends StatelessWidget {
  const PersonaListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppState state = Provider.of<AppState>(context);
    final personaList = state.personaData.personas.values.toList();
    personaList.sort(
      (a, b) =>
          (state.personaData.arcana.indexOf(a.arcana) -
                  state.personaData.arcana.indexOf(b.arcana)) !=
              0
          ? state.personaData.arcana.indexOf(a.arcana) -
                state.personaData.arcana.indexOf(b.arcana)
          : (a.unlockMethod.index - b.unlockMethod.index) != 0
          ? a.unlockMethod.index - b.unlockMethod.index
          : (a.level - b.level) != 0
          ? a.level - b.level
          : a.name.compareTo(b.name),
    );

    return ListView(
      children: [
        SizedBox(height: 16.0),
        ...personaList.map((persona) {
          return PersonaListItem(persona: persona);
        }),
      ],
    );
  }
}
