import 'package:flutter/material.dart%20';

class SortOption {
  final String label;
  final String value;
  final IconData? icon;
  final bool isDefault;

  SortOption({
    required this.label,
    required this.value,
    this.icon,
    this.isDefault = false,
  });
}

class FilterOption {
  final String label;
  final String value;
  final IconData? icon;

  FilterOption({
    required this.label,
    required this.value,
    this.icon,
  });
}
