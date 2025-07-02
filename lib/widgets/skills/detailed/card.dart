import 'package:flutter/material.dart';
import 'package:persona_assistant/types/extensions.dart';

class DetailedSkillCardBox extends StatelessWidget {
  final String skillCard;

  const DetailedSkillCardBox({super.key, required this.skillCard});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.0),
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface.withAlpha(50),
          width: 1.0,
        ),
        color: Theme.of(context).colorScheme.primary.withAlpha(120),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Row(
          children: [
            Text('Skill card: ', style: Theme.of(context).textTheme.bodyLarge!),
            Text(
              skillCard.capitalize(),
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSecondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
