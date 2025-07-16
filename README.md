# Persona Assistant

A mobile app for Persona 3 Reload fusion data, inspired by the original [megaten-fusion-tool](https://github.com/aqiu384/megaten-fusion-tool) but with a modern, mobile-only UI and a subset of features.

---

## Features

- **Persona List**: Browse, filter, and sort all personas.
- **Skills List**: Browse, filter, and sort all skills.
- **Shadow List**: Browse, filter, and sort all shadows.
- **Detailed Persona View**: Tabs for info, fusion recipes, and fission sources for each persona.
- **Unlock Tracking**: Mark personas as unlocked by various methods (e.g., story, requests, fusion).
- **Modern UI**: Catppuccin theme, neumorphic design.
- **Offline Data**: Uses local data, does not need network connection.

---

## Huge Credits & Inspiration

This project is heavily inspired by and only possible thanks to [aqiu384/megaten-fusion-tool](https://github.com/aqiu384/megaten-fusion-tool). All data, much of the logic, and the core idea are derived from that amazing project. Please check out the original for the full feature set and web experience!

---

## Limitations

- Only a subset of features from the original megaten-fusion-tool are implemented.
  - No recipe generation.
  - Fusion chart is not displayed.
- This app was designed to be **mobile-only**. It does not scale well to desktop or larger screens in general.
- I will only be creating releases for Android. I do not own any Apple devices, so I cannot build for iOS.
  - Feel free to clone the repo and build for iOS yourself if you want to try it out.
  - Refer to the [Flutter documentation](https://docs.flutter.dev/platform-integration/ios/setup) for more information.
- Currently, the app only supports Persona 3 Reload.
  - I plan to add support for Persona 5 Royal and Persona 4 Golden in the near future.
  - Other games will probably not be added as at that point, its probably better to just create a PR to improve the original project's UI.

---

## Getting Started

1. **Prerequisites:**

   - [Flutter](https://flutter.dev/) (latest stable)
   - [Dart](https://dart.dev/)
   - A device or emulator

2. **Clone the repository:**

   ```sh
   git clone https://github.com/TheDrone7/persona-assistant.git persona_assistant
   cd persona_assistant
   ```

3. **Install dependencies:**

   ```sh
   flutter pub get
   ```

4. **Run the app:**
   ```sh
   flutter run
   ```

---

## Acknowledgements

- [aqiu384/megaten-fusion-tool](https://github.com/aqiu384/megaten-fusion-tool) — Original project, data, and logic
- [Catppuccin](https://catppuccin.com/) — UI theme
- [Font Awesome](https://fontawesome.com/) — Icons

---

_This project is a fan work and is not affiliated with Atlus or SEGA._
