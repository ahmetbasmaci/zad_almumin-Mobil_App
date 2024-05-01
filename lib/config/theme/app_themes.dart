import 'package:flutter/material.dart';
import 'package:zad_almumin/core/utils/resources/resources.dart';
import 'theme_colors.dart';

class AppThemes {
  static List<ThemeData> themes = [_light, _dark].toList();

  static ThemeColors get lightColor => ThemeColors(
        brightness: Brightness.light,
        background: const Color(0xFFf5f5f5),
        primary: const Color.fromARGB(255, 25, 122, 85),
        secondary: const Color(0xFF02a3ee),
        third: const Color(0xFFa3ee02),
        success: const Color.fromARGB(255, 0, 135, 43),
        error: const Color(0xFFee022d),
        warning: const Color(0xFFeec302),
        onError: Colors.white,
        onSuccess: Colors.white,
      );

  static ThemeColors get darkColor => ThemeColors(
        brightness: Brightness.dark,
        background: const Color.fromARGB(255, 37, 37, 38),
        primary: const Color.fromARGB(255, 71, 136, 109),
        secondary: const Color(0xFF02a3ee),
        third: const Color(0xFFa3ee02),
        success: const Color(0xFF02ee4d),
        error: const Color(0xFFee022d),
        warning: const Color(0xFFeec302),
        onError: Colors.white,
        onSuccess: Colors.white,
      );

  static final ThemeData _light = _setTheme(lightColor);

  static final ThemeData _dark = _setTheme(darkColor);

  static ThemeData _setTheme(ThemeColors themeColors) {
    return ThemeData(
      colorScheme: themeColors.brightness == Brightness.dark
          ? ColorScheme.dark(
              primary: themeColors.primary,
              error: themeColors.error,
              secondary: themeColors.secondary,
              background: themeColors.background,
            )
          : ColorScheme.light(
              primary: themeColors.primary,
              error: themeColors.error,
              secondary: themeColors.secondary,
              background: themeColors.background,
            ),
      iconTheme: _appIconThemeData(themeColors),
      iconButtonTheme: _appIconButtonThemeData(themeColors),
      textTheme: _appTextTheme(themeColors),
      dialogTheme: _appDialogTheme(themeColors),
      listTileTheme: _appListTileThemeData(themeColors),
    );
  }

  static IconThemeData _appIconThemeData(ThemeColors themeColors) {
    return IconThemeData(
      color: themeColors.primary,
      size: AppSizes.icon,
    );
  }

  static IconButtonThemeData _appIconButtonThemeData(ThemeColors themeColors) {
    return IconButtonThemeData(
      style: ButtonStyle(
        iconSize: MaterialStateProperty.all<double>(AppSizes.icon),
        foregroundColor: MaterialStateProperty.all<Color>(themeColors.primary),
      ),
    );
  }

  static TextTheme _appTextTheme(ThemeColors themeColors) {
    String fontFamily = AppFonts.naskh.name;
    return TextTheme(
      titleLarge: TextStyle(fontFamily: fontFamily, fontSize: 23),
      titleMedium: TextStyle(fontFamily: fontFamily, fontSize: 21),
      bodyMedium: TextStyle(fontFamily: fontFamily, fontSize: 17),
    );
  }

  static ListTileThemeData _appListTileThemeData(ThemeColors themeColors) {
    return ListTileThemeData(
      tileColor: themeColors.background,
      selectedColor: themeColors.primary,
    );
  }

  static DialogTheme _appDialogTheme(ThemeColors themeColors) {
    return DialogTheme(
      backgroundColor: themeColors.background,
      elevation: 0,
    );
  }
}
