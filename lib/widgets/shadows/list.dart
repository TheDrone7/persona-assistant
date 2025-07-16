import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../state/state.dart';
import 'shadow.dart';

/// The main page widget for displaying a list of Shadows.
class ShadowsListPage extends StatelessWidget {
  /// Creates a [ShadowsListPage].
  const ShadowsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppState state = Provider.of<AppState>(context);

    return Observer(
      builder: (_) => ListView(
        children: [
          const SizedBox(height: 16.0),
          ...state.filteredShadows.map((shadow) {
            return ShadowListItem(shadow: shadow);
          }),
        ],
      ),
    );
  }
}
