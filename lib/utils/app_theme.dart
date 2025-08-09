import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.white,
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      background: AppColors.white,
      surface: AppColors.surface,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onBackground: AppColors.text,
      onSurface: AppColors.text,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.text),
      bodyMedium: TextStyle(color: AppColors.text),
    ),
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: AppColors.primary.withOpacity(0.1),
      labelTextStyle: MaterialStateProperty.all(
        TextStyle(fontWeight: FontWeight.w600, color: AppColors.primary),
      ),
      iconTheme: MaterialStateProperty.resolveWith<IconThemeData>((states) {
        if (states.contains(MaterialState.selected)) {
          return IconThemeData(color: AppColors.primary);
        }
        return const IconThemeData(color: Colors.grey);
      }),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.darkPrimary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    colorScheme: ColorScheme.dark(
      primary: AppColors.darkPrimary,
      secondary: AppColors.secondary,
      background: AppColors.darkBackground,
      surface: AppColors.darkSurface,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onBackground: AppColors.darkText,
      onSurface: AppColors.darkText,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.darkText),
      bodyMedium: TextStyle(color: AppColors.darkText),
    ),
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: AppColors.darkPrimary.withOpacity(0.1),
      labelTextStyle: MaterialStateProperty.all(
        TextStyle(fontWeight: FontWeight.w600, color: AppColors.darkPrimary),
      ),
      iconTheme: MaterialStateProperty.resolveWith<IconThemeData>((states) {
        if (states.contains(MaterialState.selected)) {
          return IconThemeData(color: AppColors.darkPrimary);
        }
        return const IconThemeData(color: Colors.grey);
      }),
    ),
  );
}
