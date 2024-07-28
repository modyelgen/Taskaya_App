import 'package:flutter/material.dart';
import 'package:taskaya/core/utilites/app_theme/colors.dart';
ThemeData lightTheme=ThemeData(
    scaffoldBackgroundColor:whiteColor,
    primaryColor: whiteColor,
    primaryColorDark: darkColor,
    iconTheme: IconThemeData(color:darkColor),
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: 'Lato',
    colorScheme: ColorScheme.light(
      primary: darkColor,
    ),
    iconButtonTheme: const IconButtonThemeData(style: ButtonStyle())
);
ThemeData darkTheme=ThemeData(
  primaryColor: darkColor,
  primaryColorLight: whiteColor,
  scaffoldBackgroundColor:darkColor,
  iconTheme: IconThemeData(color:whiteColor),
  useMaterial3: true,
  brightness: Brightness.dark,
  fontFamily: 'Lato',
  colorScheme: ColorScheme.dark(
    primary: whiteColor,
  ),
);