import 'package:education_app/core/common/values/custom_text_styles.dart';
import 'package:education_app/core/res/fonts.dart';
import 'package:flutter/material.dart';

const Color primary = Color(0xff007AFF);
const Color secondary = Color(0xffFFFFFF);
const Color tertiary = Color(0xffFF3B30);
const Color alternate = Color(0xff34C759);
const Color primaryText = Color(0xff1C1C1E);
const Color secondaryText = Color(0xff8E8E93);
const Color primaryBG = Color(0xffFFFFFF);
const Color secondaryBG = Color(0xffF2F2F7);
const Color accent1 = Color(0xff5AC8FA);
const Color accent2 = Color(0xffFF9500);
const Color accent3 = Color(0xffFF2D55);
const Color accent4 = Color(0xffC69C6D);
const Color success = Color(0xff34C759);
const Color error = Color(0xffFF3B30);
const Color warning = Color(0xffFFCC00);
const Color info = Color(0xff007AFF);

class LightTheme {
  static ThemeData buildLightTheme() {
    final systemLightTheme = ThemeData.light();
    return systemLightTheme.copyWith(
      brightness: Brightness.light,
      scaffoldBackgroundColor: primaryBG,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: primaryBG,
        unselectedItemColor: secondaryText,
      ),
      unselectedWidgetColor: secondaryText,
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: secondaryBG,
      ),
      textTheme: const TextTheme().apply(
        fontFamily: Fonts.poppins,
        bodyColor: primaryText,
        displayColor: primaryText,
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: tertiary,
        hoverColor: primary,
        textTheme: ButtonTextTheme.accent,
      ),
      buttonBarTheme: const ButtonBarThemeData(
        buttonTextTheme: ButtonTextTheme.accent,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: primaryBG,
        titleTextStyle: title2.copyWith(color: primaryText),
        actionsIconTheme: const IconThemeData(color: primaryText),
      ),
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: primary,
        onPrimary: primary,
        secondary: secondary,
        onSecondary: primaryText,
        background: primaryBG,
        onBackground: secondaryBG,
        error: error,
        onError: warning,
        surface: success,
        onSurface: info,
        tertiary: tertiary,
      ),
    );
  }
}
