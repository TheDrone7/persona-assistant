import 'package:catppuccin_flutter/catppuccin_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Define the Catppuccin theme based
/// Since the flavor is always mocha, it is used directly.
ThemeData catpuccinTheme() {
  Flavor flavor = catppuccin.mocha;
  Color primaryColor = flavor.mauve;
  Color secondaryColor = flavor.lavender;

  return ThemeData(
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      elevation: 0,
      titleTextStyle: GoogleFonts.montserrat(
        color: flavor.text,
        fontSize: 22,
        fontWeight: FontWeight.normal,
      ),
      iconTheme: IconThemeData(color: flavor.overlay1),
      backgroundColor: flavor.crust,
      foregroundColor: flavor.mantle,
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: flavor.crust,
      onPrimary: primaryColor,
      secondary: flavor.mantle,
      onSecondary: secondaryColor,
      error: flavor.surface1,
      onError: flavor.red,
      surface: flavor.base,
      onSurface: flavor.text,
    ),
    textTheme: GoogleFonts.quicksandTextTheme().apply(
      bodyColor: flavor.text,
      displayColor: primaryColor,
    ),
    highlightColor: primaryColor.withAlpha(50),
    splashColor: primaryColor.withAlpha(120),
    dividerColor: flavor.overlay2,
    listTileTheme: ListTileThemeData(
      textColor: flavor.text,
      iconColor: flavor.text,
      tileColor: flavor.crust.withAlpha(180),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      elevation: 0,
    ),
  );
}
