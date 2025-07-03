import 'package:flutter/material.dart';
import 'package:persona_data/lib.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:persona_assistant/state/state.dart';

class UnlockSettingsCategory extends StatelessWidget {
  final PersonaUnlockMethod representedMethod;
  const UnlockSettingsCategory({super.key, required this.representedMethod});

  @override
  Widget build(BuildContext context) {
    final AppState state = Provider.of<AppState>(context);
    final Map<String, Persona> personas = Map.fromEntries(
      state.personaData.unlockablePersonas.entries.where(
        (entry) => entry.value.unlockMethod == representedMethod,
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        iconColor: Theme.of(context).colorScheme.onSurface,
        title: Text(personas.values.first.conditionShort),
        initiallyExpanded: true,
        children: [
          Observer(
            builder: (_) => Container(
              decoration: BoxDecoration(
                border: BorderDirectional(
                  top: BorderSide(
                    color: Theme.of(context).dividerColor.withAlpha(50),
                  ),
                ),
              ),
              child: SwitchListTile(
                activeTrackColor: Theme.of(
                  context,
                ).colorScheme.tertiary.withAlpha(150),
                title: Text(
                  'Select All',
                ),
                subtitle: Text(
                  'All ${personas.values.first.conditionShort.toLowerCase()} personas',
                ),
                value: personas.keys.every((p) => state.personaUnlocks[p]!),
                onChanged: (bool value) {
                  for (final String personaName in personas.keys) {
                    state.setPersonaUnlock(personaName, value);
                  }
                },
              ),
            ),
          ),
          ...personas.entries.map((entry) {
            final String personaName = entry.key;
            final Persona persona = entry.value;
            return Observer(
              builder: (_) => Container(
                decoration: BoxDecoration(
                  border: BorderDirectional(
                    top: BorderSide(
                      color: Theme.of(context).dividerColor.withAlpha(50),
                    ),
                  ),
                ),
                child: SwitchListTile(
                  activeTrackColor: Theme.of(
                    context,
                  ).colorScheme.tertiary.withAlpha(150),
                  title: Text(persona.name),
                  subtitle: Text(persona.fusionCondition ?? ''),
                  value: state.personaUnlocks[personaName]!,
                  onChanged: (bool value) {
                    state.setPersonaUnlock(personaName, value);
                  },
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
