import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../types/filters.dart';
import 'filters_button.dart';

/// A widget that provides controls for sorting and filtering using modal bottom sheets.
///
/// Displays two buttons: one for sorting and one for filtering. When pressed, each button
/// opens a modal with the respective options.
class SortAndFilterControls extends StatelessWidget {
  final Widget sortIcon;
  final String sortLabel;
  final List<SortOption> sortOptions;
  final void Function(SortOption) onSortChanged;

  final String filterLabel;
  final List<FilterOption> filterOptions;
  final void Function(FilterOption) onFilterChanged;

  const SortAndFilterControls({
    super.key,
    required this.sortIcon,
    required this.sortLabel,
    required this.sortOptions,
    required this.onSortChanged,
    required this.filterLabel,
    required this.filterOptions,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: FiltersButton(
                icon: sortIcon,
                onPressed: () =>
                    _showSortOptions(context, sortOptions, onSortChanged),
                child: Text(sortLabel.toUpperCase()),
              ),
            ),
            const VerticalDivider(),
            Expanded(
              child: FiltersButton(
                icon: const FaIcon(FontAwesomeIcons.filter),
                onPressed: () =>
                    _showFilterOptions(context, filterOptions, onFilterChanged),
                child: Text(filterLabel.toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Shows a modal bottom sheet with sort options.
  void _showSortOptions(
    BuildContext context,
    List<SortOption> options,
    void Function(SortOption) onChanged,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return _SortOptionsModal(options: options, onChanged: onChanged);
      },
    );
  }

  /// Shows a modal bottom sheet with filter options.
  void _showFilterOptions(
    BuildContext context,
    List<FilterOption> options,
    void Function(FilterOption) onChanged,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return _FilterOptionsModal(options: options, onChanged: onChanged);
      },
    );
  }
}

/// Modal widget for displaying sort options.
class _SortOptionsModal extends StatelessWidget {
  final List<SortOption> options;
  final void Function(SortOption) onChanged;

  const _SortOptionsModal({required this.options, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
      itemCount: options.length,
      itemBuilder: (context, index) {
        final option = options[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: FiltersButton(
            key: Key(option.value),
            icon: option.icon,
            onPressed: () {
              onChanged(option);
              Navigator.pop(context);
            },
            child: Text(option.label.toUpperCase()),
          ),
        );
      },
    );
  }
}

/// Modal widget for displaying filter options.
class _FilterOptionsModal extends StatelessWidget {
  final List<FilterOption> options;
  final void Function(FilterOption) onChanged;

  const _FilterOptionsModal({required this.options, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
      itemCount: options.length,
      itemBuilder: (context, index) {
        final option = options[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: FiltersButton(
            key: Key(option.value),
            onPressed: () {
              onChanged(option);
              Navigator.pop(context);
            },
            child: Text(option.label.toUpperCase()),
          ),
        );
      },
    );
  }
}
