import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'state/state.dart';
import 'theme.dart';
import 'widgets/home/home.dart';

final store = AppState();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await store.initialize();

  runApp(Provider<AppState>.value(value: store, child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Persona Assistant',
      theme: catpuccinTheme(),
      home: NavigationHomePage(),
    );
  }
}
