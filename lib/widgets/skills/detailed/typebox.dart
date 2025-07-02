import 'package:flutter/material.dart';
import 'package:persona_assistant/types/extensions.dart';

class DetailedSkillTypeBox extends StatelessWidget {
  final String imagePath;
  final String skillName;

  const DetailedSkillTypeBox({
    super.key,
    required this.imagePath,
    required this.skillName,
  });

  @override
  Widget build(BuildContext context) {
    final String typeName = imagePath
        .split('.')
        .first
        .split('/')
        .last
        .capitalize();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28.0),
          bottom: Radius.zero,
        ),
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.onSurface.withAlpha(50),
            width: 1.0,
          ),
        ),
        color: Theme.of(context).colorScheme.primary.withAlpha(150),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('assets/p3r/$imagePath'),
            const SizedBox(width: 20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    skillName,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    '$typeName Skill',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
