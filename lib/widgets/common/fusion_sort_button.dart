import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../constants/sort_options.dart';
import '../../types/filters.dart';
import 'filters_button.dart';

/// A reusable sort button for fusion and fission tabs.
///
/// This widget provides a styled button with a bottom sheet for selecting sort options.
/// It manages its own local state for the selected sort option.
class FusionSortButton extends StatefulWidget {
  /// The number of ingredients in the fusion/fission (typically 2).
  final int ingredientCount;

  /// Whether this is for fusions (true) or fissions (false).
  /// This determines which sort options are available.
  final bool isFusion;

  /// Callback to notify parent when sort order changes.
  final void Function(SortOption)? onSortChanged;

  /// Creates a [FusionSortButton] widget.
  const FusionSortButton({
    super.key,
    required this.ingredientCount,
    this.isFusion = false,
    this.onSortChanged,
  });

  @override
  State<FusionSortButton> createState() => _FusionSortButtonState();
}

class _FusionSortButtonState extends State<FusionSortButton> {
  late SortOption _sortOrder;

  @override
  void initState() {
    super.initState();
    _sortOrder = widget.isFusion
        ? fusionSortOptions(widget.ingredientCount).first
        : fissionSortOptions(widget.ingredientCount).first;
  }

  void _setSortOrder(SortOption order) {
    setState(() {
      _sortOrder = order;
    });
    widget.onSortChanged?.call(order);
  }

  void _showSortOptions(BuildContext context) {
    final options = widget.isFusion
        ? fusionSortOptions(widget.ingredientCount)
        : fissionSortOptions(widget.ingredientCount);

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return _SortOptionsModal(options: options, onChanged: _setSortOrder);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary.withAlpha(16),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withAlpha(40),
          width: 1.5,
        ),
      ),
      child: IconButton(
        onPressed: () => _showSortOptions(context),
        icon:
            _sortOrder.icon ??
            FaIcon(
              FontAwesomeIcons.sort,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
        style: IconButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.all(8),
        ),
      ),
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
