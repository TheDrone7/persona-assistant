import 'package:flutter/material.dart ';
import 'package:provider/provider.dart';

import 'package:persona_assistant/state/state.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../filters_button.dart';
import 'package:persona_data/lib.dart';

class PersonaSkillFilters extends StatelessWidget {
  const PersonaSkillFilters({super.key});

  @override
  Widget build(BuildContext context) {
    final AppState state = Provider.of<AppState>(context);
    final List<String> sortOptions = [
      'default',
      'name (a - z)',
      'name (z - a)',
      'cost (▽)',
      'cost (△)',
      'rank (▽)',
      'rank (△)',
    ];

    final List<String> skillTypes = [
      'all',
      ...CombatElement.values.map((e) => e.name.toLowerCase()),
      ...SkillType.values
          .where((e) => e != SkillType.attack)
          .map((e) => e.name.toLowerCase()),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      child: IntrinsicHeight(
        child: Row(
          spacing: 4,
          children: [
            Expanded(
              child: FiltersButton(
                icon: Icon(Icons.sort),
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
                              state.setSkillSortOrder(
                                sortOptions[index].toLowerCase(),
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
                  builder: (_) => Text(state.skillSortOrder.toUpperCase()),
                ),
              ),
            ),
            VerticalDivider(),
            Expanded(
              child: FiltersButton(
                icon: Icon(Icons.filter_list),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 20.0,
                        ),
                        itemCount: skillTypes.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FiltersButton(
                            key: Key(skillTypes[index].toLowerCase()),
                            child: Text(skillTypes[index].toUpperCase()),
                            onPressed: () {
                              state.setSkillFilter(
                                skillTypes[index].toLowerCase(),
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
                  builder: (_) => Text(state.skillFilter.toUpperCase()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
