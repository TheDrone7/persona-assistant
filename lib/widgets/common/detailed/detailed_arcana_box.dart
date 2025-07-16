import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:persona_data/lib.dart';

/// A reusable arcana box widget for detailed persona and shadow pages.
///
/// Displays arcana icon, title, and subtitle with customizable content.
class DetailedArcanaBox extends StatelessWidget {
  /// The arcana to display.
  final Arcana arcana;

  /// The main title (e.g., persona or shadow name, or level info).
  final String title;

  /// The subtitle (e.g., arcana name, area, or special info).
  final String subtitle;

  /// Optional image padding.
  final EdgeInsetsGeometry imagePadding;

  const DetailedArcanaBox({
    super.key,
    required this.arcana,
    required this.title,
    required this.subtitle,
    this.imagePadding = const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).appBarTheme.backgroundColor,
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).colorScheme.outline.withAlpha(120),
                width: 1.0,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: imagePadding,
                child: SizedBox(
                  height: 56.0,
                  child: Image.asset('assets/p3r/${arcana.imagePath}'),
                ),
              ),
              const SizedBox(width: 24.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineMedium!
                          .copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
