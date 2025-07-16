import 'package:flutter/material.dart';
import 'package:persona_assistant/types/extensions.dart';

import '../../common/card.dart' as common;

class DetailedSkillEffectBox extends StatelessWidget {
  final String effectText;

  const DetailedSkillEffectBox({super.key, required this.effectText});

  @override
  Widget build(BuildContext context) {
    return common.Card(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Additional Effect',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              Expanded(
                child: Text(
                  effectText.startsWith('x')
                      ? effectText
                      : effectText.capitalize(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
