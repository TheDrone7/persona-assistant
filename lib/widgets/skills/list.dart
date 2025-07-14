import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:persona_assistant/state/state.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'skill.dart';

/// The main page widget for displaying a list of skills.
class SkillsPage extends StatelessWidget {
  /// Creates a [SkillsPage].
  const SkillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppState state = Provider.of<AppState>(context);
    return Observer(
      builder: (_) => ListView(
        children: [
          const SizedBox(height: 16.0),
          ...state.filteredSkills.map((skill) {
            return SkillListItem(skill: skill);
          }),
        ],
      ),
    );
  }
}
