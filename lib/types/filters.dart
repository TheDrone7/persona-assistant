import 'package:flutter/material.dart';

/// Represents a sorting option for lists, with an optional icon and default flag.
@immutable
class SortOption {
  /// The label to display for this sort option.
  final String label;

  /// The value used to identify this sort option.
  final String value;

  /// The icon to display for this sort option (optional).
  final Widget? icon;

  /// Whether this is the default sort option.
  final bool isDefault;

  const SortOption({
    required this.label,
    required this.value,
    this.icon,
    this.isDefault = false,
  });
}

/// Represents a filter option for lists.
@immutable
class FilterOption {
  /// The label to display for this filter option.
  final String label;

  /// The value used to identify this filter option.
  final String value;

  const FilterOption({required this.label, required this.value});
}
