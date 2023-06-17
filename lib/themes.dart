import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'colors.dart';

class ThemeSwitch extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void switchTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class KodeksThemes {
  static final lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      color: kGreenColor
    ),
    canvasColor: kCardColor,
    textTheme: const TextTheme(
        bodyLarge: TextStyle(color: kFontBlackC),
        bodyMedium: TextStyle(color: kFontBlackC),
        bodySmall: TextStyle(color: kFontBlackC)),
    fontFamily: 'Outfit',
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(),
    primaryColor: kGreenColor,
    cardColor: kCardColor,
    inputDecorationTheme: InputDecorationTheme(
      hoverColor: kGreenColor,
      focusColor: kTextFieldColor,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: kTextFieldBorderC),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: kTextFieldBorderC),
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );


  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}
