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
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 2),
      child: ExpansionTile(
        backgroundColor: Theme.of(context).colorScheme.surface.withAlpha(200),
        collapsedBackgroundColor: Theme.of(
          context,
        ).colorScheme.surface.withAlpha(200),
        title: Text(
          personas.values.first.conditionShort,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onPrimary,
            backgroundColor: Colors.transparent,
          ),
        ),
        initiallyExpanded: true,
        trailing: SizedBox.shrink(),
        enabled: false,
        children: [
          Observer(
            builder: (_) {
              final bool allSelected = personas.keys.every(
                (p) => state.personaUnlocks[p]!,
              );
              return Container(
                decoration: BoxDecoration(
                  border: BorderDirectional(
                    top: BorderSide(
                      color: Theme.of(context).dividerColor.withAlpha(50),
                    ),
                  ),
                ),
                child: SwitchListTile(
                  tileColor: Colors.transparent,
                  activeTrackColor: Theme.of(
                    context,
                  ).colorScheme.tertiary.withAlpha(150),
                  title: Text(
                    allSelected ? 'Disable All' : 'Enable All',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                  subtitle: Text(
                    'All ${personas.values.first.conditionShort.toLowerCase()} personas',
                  ),
                  value: allSelected,
                  onChanged: (bool value) {
                    for (final String personaName in personas.keys) {
                      state.setPersonaUnlock(personaName, value);
                    }
                  },
                ),
              );
            },
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
                  tileColor: Colors.transparent,
                  activeTrackColor: Theme.of(
                    context,
                  ).colorScheme.tertiary.withAlpha(150),
                  title: Text(
                    persona.name,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
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
