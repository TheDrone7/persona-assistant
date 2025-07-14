import 'package:flutter/material.dart';

/// A reusable section header widget for consistent section titles.
class SectionHeader extends StatelessWidget {
  final String title;
  final EdgeInsetsGeometry padding;

  /// Creates a section header with [title] and optional [padding].
  /// Defaults to horizontal: 18, vertical: 4.
  const SectionHeader({
    super.key,
    required this.title,
    this.padding = const EdgeInsets.symmetric(horizontal: 18.0, vertical: 4.0),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
      ),
    );
  }
} 