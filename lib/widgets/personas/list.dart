import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:persona_assistant/state/state.dart';
import 'persona.dart';

/// The main page widget for displaying a list of personas.
class PersonaListPage extends StatelessWidget {
  /// Creates a [PersonaListPage].
  const PersonaListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppState state = Provider.of<AppState>(context);

    return Observer(
      builder: (_) => ListView(
        children: [
          const SizedBox(height: 16.0),
          ...state.filteredPersonas.map((persona) {
            return PersonaListItem(persona: persona);
          }),
        ],
      ),
    );
  }
}
