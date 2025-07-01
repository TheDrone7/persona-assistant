import 'package:flutter/material.dart ';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:persona_assistant/state/state.dart';
import 'package:persona_assistant/constants/sort_options.dart';
import 'package:persona_assistant/constants/filter_choices.dart';
import '../filters_button.dart';

class PersonaFilters extends StatelessWidget {
  const PersonaFilters({super.key});

  @override
  Widget build(BuildContext context) {
    final AppState state = Provider.of<AppState>(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      child: IntrinsicHeight(
        child: Row(
          spacing: 4,
          children: [
            Expanded(
              child: FiltersButton(
                icon: Observer(
                  builder: (_) =>
                      state.personaSortOrder.icon ??
                      FaIcon(FontAwesomeIcons.sort),
                ),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 20.0,
                        ),
                        itemCount: personaSortOptions.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FiltersButton(
                            key: Key(personaSortOptions[index].value),
                            icon: personaSortOptions[index].icon,
                            child: Text(
                              personaSortOptions[index].label.toUpperCase(),
                            ),
                            onPressed: () {
                              state.setPersonaSortOrder(
                                personaSortOptions[index].value.toLowerCase(),
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
                  builder: (_) =>
                      Text(state.personaSortOrder.label.toUpperCase()),
                ),
              ),
            ),
            VerticalDivider(),
            Expanded(
              child: FiltersButton(
                icon: FaIcon(FontAwesomeIcons.filter),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 20.0,
                        ),
                        itemCount: personaFilterOptions.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FiltersButton(
                            key: Key(personaFilterOptions[index].value),
                            child: Text(
                              personaFilterOptions[index].label.toUpperCase(),
                            ),
                            onPressed: () {
                              state.setPersonaArcanaFilter(
                                personaFilterOptions[index],
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
                  builder: (_) =>
                      Text(state.personaArcanaFilter.label.toUpperCase()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
