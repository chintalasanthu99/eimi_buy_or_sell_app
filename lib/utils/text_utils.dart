import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextUtils {
  /// Heading text style (e.g. titles, page headers)
  static TextStyle headingStyle(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge!.copyWith(
      fontWeight: FontWeight.bold,
      fontSize: 20,
    );
  }

  /// Subheading style (section titles)
  static TextStyle subheadingStyle(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: 16,
    );
  }

  /// Body style for general text
  static TextStyle bodyStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium!;
  }

  /// Small caption text (e.g. hints, descriptions)
  static TextStyle smallTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodySmall!.copyWith(
      fontSize: 12,
    );
  }

  /// Button text
  static TextStyle buttonTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.labelLarge!.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: Colors.white
    );
  }

  /// Error text
  static TextStyle errorTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
      color: Colors.red,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );
  }

  /// Custom font size (use if specific size needed)
  static TextStyle customStyle(BuildContext context,
      {double size = 14,
        FontWeight weight = FontWeight.normal,
        Color? color}) {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
      fontSize: size,
      fontWeight: weight,
      color: color ?? Theme.of(context).textTheme.bodyMedium!.color,
    );
  }


  static TextStyle safeGoogleFont(
      String fontFamily, {
        TextStyle? textStyle,
        Color? color,
        Color? backgroundColor,
        double? fontSize,
        FontWeight? fontWeight,
        FontStyle? fontStyle,
        double? letterSpacing,
        double? wordSpacing,
        TextBaseline? textBaseline,
        double? height,
        Locale? locale,
        Paint? foreground,
        Paint? background,
        List<Shadow>? shadows,
        List<FontFeature>? fontFeatures,
        TextDecoration? decoration,
        Color? decorationColor,
        TextDecorationStyle? decorationStyle,
        double? decorationThickness,
      }) {
    try {
      return GoogleFonts.getFont(
        fontFamily,
        textStyle: textStyle,
        color: color,
        backgroundColor: backgroundColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        textBaseline: textBaseline,
        height: height,
        locale: locale,
        foreground: foreground,
        background: background,
        shadows: shadows,
        fontFeatures: fontFeatures,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
      );
    } catch (ex) {
      return GoogleFonts.getFont(
        "Source Sans Pro",
        textStyle: textStyle,
        color: color,
        backgroundColor: backgroundColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        textBaseline: textBaseline,
        height: height,
        locale: locale,
        foreground: foreground,
        background: background,
        shadows: shadows,
        fontFeatures: fontFeatures,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
      );
    }
  }

  static const appBarTitle = TextStyle(fontSize: 20, fontWeight: FontWeight.w600);
  static const titleMedium = TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
  static const bodyLarge = TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
  static const bodyMedium = TextStyle(fontSize: 14);
}
