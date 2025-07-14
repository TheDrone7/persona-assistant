import 'package:flutter/material.dart ';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:persona_assistant/state/state.dart';
import 'package:persona_assistant/constants/sort_options.dart';
import 'package:persona_assistant/constants/filter_options.dart';
import '../common/filters_button.dart';

class PersonaSkillFilters extends StatelessWidget {
  const PersonaSkillFilters({super.key});

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
                      (state.skillSortOrder.icon ??
                      const FaIcon(FontAwesomeIcons.arrowDownWideShort)),
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
                        itemCount: skillSortOptions.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FiltersButton(
                            key: Key(skillSortOptions[index].value),
                            icon: skillSortOptions[index].icon,
                            child: Text(
                              skillSortOptions[index].label.toUpperCase(),
                            ),
                            onPressed: () {
                              state.setSkillSortOrder(skillSortOptions[index]);
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
                      Text(state.skillSortOrder.label.toUpperCase()),
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
                        itemCount: skillFilterOptions.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FiltersButton(
                            key: Key(
                              skillFilterOptions[index].value.toLowerCase(),
                            ),
                            child: Text(
                              skillFilterOptions[index].label.toUpperCase(),
                            ),
                            onPressed: () {
                              state.setSkillFilter(skillFilterOptions[index]);
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Observer(
                  builder: (_) => Text(state.skillFilter.label.toUpperCase()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
