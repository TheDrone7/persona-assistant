import 'package:flutter/material.dart ';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:persona_assistant/state/state.dart';
import 'package:persona_assistant/constants/sort_options.dart';
import 'package:persona_assistant/constants/filter_options.dart';
import '../filters_button.dart';

class ShadowFilters extends StatelessWidget {
  const ShadowFilters({super.key});

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
                      (state.shadowSortOrder.icon ??
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
                        itemCount: shadowSortOptions.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FiltersButton(
                            key: Key(shadowSortOptions[index].value),
                            icon: shadowSortOptions[index].icon,
                            child: Text(
                              shadowSortOptions[index].label.toUpperCase(),
                            ),
                            onPressed: () {
                              state.setShadowSortOrder(
                                shadowSortOptions[index],
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
                      Text(state.shadowSortOrder.label.toUpperCase()),
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
                        itemCount: shadowFilterOptions.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FiltersButton(
                            key: Key(
                              shadowFilterOptions[index].value.toLowerCase(),
                            ),
                            child: Text(
                              shadowFilterOptions[index].label.toUpperCase(),
                            ),
                            onPressed: () {
                              state.setShadowFilter(shadowFilterOptions[index]);
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Observer(
                  builder: (_) => Text(state.shadowFilter.label.toUpperCase()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
