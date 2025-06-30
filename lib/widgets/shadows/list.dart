import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:persona_assistant/state/state.dart';

import 'shadow.dart';

class ShadowsListPage extends StatelessWidget {
  const ShadowsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppState state = Provider.of<AppState>(context);
    final shadowsList = state.personaData.shadows.values.toList();
    shadowsList.sort(
      (a, b) => (a.level - b.level) != 0
          ? a.level - b.level
          : a.name.compareTo(b.name),
    );

    return ListView(
      children: [
        SizedBox(height: 16.0),
        ...shadowsList.map((shadow) {
          return ShadowListItem(shadow: shadow);
        }),
      ],
    );
  }
}
