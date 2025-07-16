# p3r_data

A Dart package providing structured data and utilities for Persona 3 Reload, including persona, shadow, skill, and fusion data. This package is designed for apps and tools that need to access, query, or process Persona 3 Reload's game data in a type-safe and efficient way.

## Features

- Typed models for personas, shadows, skills, affinities, and fusions
- Data readers for loading and parsing bundled JSON data
- Fusion logic and helpers for calculating possible fusions

## Getting Started

Add `p3r_data` to your `pubspec.yaml`:

```yaml
dependencies:
  p3r_data:
    path: packages/p3r_data
```

Import the package:

```dart
import 'package:p3r_data/lib.dart';
```

## Usage

Initialize and load persona data:

```dart
import 'package:p3r_data/lib.dart';

void main() async {
  // Create a PersonaData instance pointing to the data directory
  final personaData = PersonaData.fromPath('assets/p3r/jsons');
  await personaData.initialize(null); // Load all data

  // Access a persona by name
  final orpheus = personaData.personas['Orpheus'];
  if (orpheus != null) {
    print('Arcana: \\${orpheus.arcana}, Level: \\${orpheus.level}');
  }

  // Use fusion logic
  final fusionCalculator = personaData.fusionCalculator;
  final fusionResults = fusionCalculator.getFusionResultsWithOther(orpheus!);
  print('Orpheus can fuse with:');
  for (final result in fusionResults) {
    print('- ${result.ingredients.first.name} => ${result.result.name}');
  }
}
```

## Additional Information

- For more details, see the source code and documentation in the `lib/` directory.
  - NOTE: Most modern text editors will show you the documentation written here when you use the package.
- Contributions and issues are welcome! Please open an issue or pull request on the repository.
- Data files are located in `assets/p3r/jsons/`.
