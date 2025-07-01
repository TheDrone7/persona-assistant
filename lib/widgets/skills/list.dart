import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:persona_assistant/state/state.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'skill.dart';

class SkillsPage extends StatelessWidget {
  const SkillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppState state = Provider.of<AppState>(context);
    return Observer(
      builder: (_) => ListView(
        children: [
          SizedBox(height: 16.0),
          ...state.filteredSkills.map((skill) {
            return SkillListItem(skill: skill);
          }),
        ],
      ),
    );
  }
}
