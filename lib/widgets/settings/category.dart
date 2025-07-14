import 'package:flutter/material.dart';
import 'package:persona_data/lib.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:persona_assistant/state/state.dart';

/// A settings category for unlocking personas by a specific method.
class UnlockSettingsCategory extends StatelessWidget {
  /// The unlock method this category represents.
  final PersonaUnlockMethod representedMethod;

  /// Creates an [UnlockSettingsCategory] for the given [representedMethod].
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
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: ExpansionTile(
        backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(120),
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
        trailing: const SizedBox.shrink(),
        enabled: false,
        children: [
          Observer(
            builder: (_) {
              final bool allSelected = personas.keys.every(
                (p) => state.personaUnlocks[p]!,
              );
              return _PersonaUnlockSwitchTile(
                title: allSelected ? 'Disable All' : 'Enable All',
                subtitle:
                    'All ${personas.values.first.conditionShort.toLowerCase()} personas',
                value: allSelected,
                onChanged: (bool value) {
                  for (final String personaName in personas.keys) {
                    state.setPersonaUnlock(personaName, value);
                  }
                },
              );
            },
          ),
          ...personas.entries.map((entry) {
            final String personaName = entry.key;
            final Persona persona = entry.value;
            return Observer(
              builder: (_) => _PersonaUnlockSwitchTile(
                title: persona.name,
                subtitle: persona.fusionCondition ?? '',
                value: state.personaUnlocks[personaName]!,
                onChanged: (bool value) {
                  state.setPersonaUnlock(personaName, value);
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}

/// A switch tile for persona unlock settings, with consistent styling and border.
class _PersonaUnlockSwitchTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _PersonaUnlockSwitchTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: BorderDirectional(
          top: BorderSide(color: Theme.of(context).dividerColor.withAlpha(50)),
        ),
      ),
      child: SwitchListTile(
        tileColor: Colors.transparent,
        activeTrackColor: Theme.of(context).colorScheme.tertiary.withAlpha(150),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
        subtitle: Text(subtitle),
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
