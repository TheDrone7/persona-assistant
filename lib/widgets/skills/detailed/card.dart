import 'package:flutter/material.dart';
import 'package:persona_assistant/widgets/common/card.dart' as common;
import 'package:persona_assistant/types/extensions.dart';

class DetailedSkillCardBox extends StatelessWidget {
  final String skillCard;

  const DetailedSkillCardBox({super.key, required this.skillCard});

  @override
  Widget build(BuildContext context) {
    return common.Card(
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
    );
  }
}
