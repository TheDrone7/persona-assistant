import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:persona_assistant/state/state.dart';
import 'package:persona_assistant/constants/sort_options.dart';
import 'package:persona_assistant/constants/filter_options.dart';
import '../common/sort_and_filter_controls.dart';

class PersonaSkillFilters extends StatelessWidget {
  const PersonaSkillFilters({super.key});

  @override
  Widget build(BuildContext context) {
    final AppState state = Provider.of<AppState>(context);

    return Observer(
      builder: (_) => SortAndFilterControls(
        sortIcon:
            state.skillSortOrder.icon ??
            const FaIcon(FontAwesomeIcons.arrowDownWideShort),
        sortLabel: state.skillSortOrder.label,
        sortOptions: skillSortOptions,
        onSortChanged: (option) => state.setSkillSortOrder(option),
        filterLabel: state.skillFilter.label,
        filterOptions: skillFilterOptions,
        onFilterChanged: (option) => state.setSkillFilter(option),
      ),
    );
  }
}
