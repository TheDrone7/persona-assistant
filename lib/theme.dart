import 'package:flutter/material.dart';
import 'package:catppuccin_flutter/catppuccin_flutter.dart';
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
      backgroundColor: flavor.crust.withAlpha(220),
      foregroundColor: flavor.mantle,
      iconTheme: IconThemeData(color: flavor.overlay2),
    ),
    iconTheme: IconThemeData(color: flavor.overlay2),
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
      tertiary: flavor.surface1,
      onTertiary: flavor.green,
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
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: flavor.crust.withAlpha(220),
      selectedItemColor: flavor.mauve,
      unselectedItemColor: flavor.text,
      selectedIconTheme: IconThemeData(color: flavor.mauve),
      unselectedIconTheme: IconThemeData(color: flavor.text),
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    ),
    tabBarTheme: TabBarThemeData(
      indicatorColor: flavor.mauve,
      labelColor: flavor.mauve,
      unselectedLabelColor: flavor.text,
      labelStyle: GoogleFonts.quicksand(),
      unselectedLabelStyle: GoogleFonts.quicksand(),
    ),
  );
}
