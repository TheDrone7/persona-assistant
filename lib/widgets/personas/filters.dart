import 'package:flutter/material.dart ';
import 'package:provider/provider.dart';

import 'package:persona_assistant/state/state.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../filters_button.dart';

class PersonaFilters extends StatelessWidget {
  const PersonaFilters({super.key});

  @override
  Widget build(BuildContext context) {
    final AppState state = Provider.of<AppState>(context);
    final List<String> sortOptions = [
      'arcana',
      'level (01 - 99)',
      'level (99 - 01)',
      'name (a - z)',
      'name (z - a)',
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      child: IntrinsicHeight(
        child: Row(
          spacing: 4,
          children: [
            Expanded(
              child: FiltersButton(
                icon: Icons.sort,
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 20.0,
                        ),
                        itemCount: sortOptions.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FiltersButton(
                            key: Key(sortOptions[index]),
                            child: Text(sortOptions[index].toUpperCase()),
                            onPressed: () {
                              state.setPersonaSortOrder(sortOptions[index].toLowerCase());
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Observer(
                  builder: (_) => Text(state.personaSortOrder.toUpperCase()),
                ),
              ),
            ),
            VerticalDivider(),
            Expanded(
              child: FiltersButton(
                icon: Icons.filter_list,
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 20.0,
                        ),
                        itemCount: state.personaData.arcana.length + 1,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FiltersButton(
                            key: Key(
                              index == 0
                                  ? 'All'
                                  : state.personaData.arcana[index - 1],
                            ),
                            child: Text(
                              index == 0
                                  ? 'ALL'
                                  : state.personaData.arcana[index - 1]
                                        .toUpperCase(),
                            ),
                            onPressed: () {
                              state.setPersonaArcanaFilter(
                                index == 0
                                    ? 'All'
                                    : state.personaData.arcana[index - 1],
                              );
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Observer(
                  builder: (_) => Text(state.personaArcanaFilter.toUpperCase()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
