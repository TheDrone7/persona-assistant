import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:persona_assistant/state/state.dart';
import 'package:persona_assistant/constants/sort_options.dart';
import 'package:persona_assistant/constants/filter_options.dart';
import '../common/sort_and_filter_controls.dart';

/// Widget for displaying sorting and filtering controls for Shadows.
class ShadowFilters extends StatelessWidget {
  /// Creates a [ShadowFilters] widget.
  const ShadowFilters({super.key});

  @override
  Widget build(BuildContext context) {
    final AppState state = Provider.of<AppState>(context);

    return Observer(
      builder: (_) => SortAndFilterControls(
        sortIcon:
            state.shadowSortOrder.icon ??
            const FaIcon(FontAwesomeIcons.arrowDownWideShort),
        sortLabel: state.shadowSortOrder.label,
        sortOptions: shadowSortOptions,
        onSortChanged: (option) => state.setShadowSortOrder(option),
        filterLabel: state.shadowFilter.label,
        filterOptions: shadowFilterOptions,
        onFilterChanged: (option) => state.setShadowFilter(option),
      ),
    );
  }
}
