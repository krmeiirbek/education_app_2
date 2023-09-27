import 'package:flutter/material.dart';

class MyColors {
  static const Color primary = Color(0xff007AfF);
  static const Color secondary = Color(0xffFfFFfF);
  static const Color tertiary = Color(0xffFF3B30);
  static const Color alternate = Color(0xff34C759);
  static const Color primaryText = Color(0xff1C1C1E);
  static const Color secondaryText = Color(0xff8E8E93);
  static const Color primaryBG = Color(0xffFFFFFF);
  static const Color secondaryBG = Color(0xffF2F2F7);
  static const Color accent1 = Color(0xff5AC8fA);
  static const Color accent2 = Color(0xffFF9500);
  static const Color accent3 = Color(0xffFF2D55);
  static const Color accent4 = Color(0xffC69C6D);
  static const Color success = Color(0xff34C759);
  static const Color error = Color(0xffFF3B30);
  static const Color warning = Color(0xffFFCC00);
  static const Color info = Color(0xff007AFF);
}


class MyTheme {
  static ThemeData buildTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: MyColors.primaryBG,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: MyColors.primaryBG,
        unselectedItemColor: MyColors.secondaryText,
      ),
      unselectedWidgetColor: MyColors.secondaryText,
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: MyColors.secondaryBG,
      ),
      textTheme: const TextTheme().apply(
        fontFamily: 'Poppins', // Use the Poppins font family
        bodyColor: MyColors.primaryText, // Use primary text color
        displayColor: MyColors.primaryText, // Use primary text color
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: MyColors.tertiary, // Use tertiary as button color
        hoverColor: MyColors.primary, // Use primary as hover color
        textTheme: ButtonTextTheme.accent,
      ),
      buttonBarTheme: const ButtonBarThemeData(
        buttonTextTheme: ButtonTextTheme.accent,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: MyColors.primaryBG,
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: MyColors.primaryText,
        ),
        actionsIconTheme: IconThemeData(
          color: MyColors.primaryText,
        ),
      ),
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: MyColors.primary,
        onPrimary: MyColors.primary,
        secondary: MyColors.secondary,
        onSecondary: MyColors.info,
        background: MyColors.primaryBG,
        onBackground: MyColors.secondaryBG,
        error: MyColors.error,
        onError: MyColors.warning,
        surface: MyColors.success,
        onSurface: MyColors.primaryText,
        tertiary: MyColors.tertiary,
      ),
    );
  }
}
