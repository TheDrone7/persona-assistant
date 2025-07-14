import 'package:flutter/material.dart';

/// A reusable vertical spacing widget for section separation.
class SectionSpacing extends StatelessWidget {
  /// The height of the spacing. Defaults to 16.0.
  final double height;
  const SectionSpacing({super.key, this.height = 16.0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
} 