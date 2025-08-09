import 'package:flutter/material.dart';
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class AppColors {
  // Light Theme
  static final Color primary = HexColor("#0F766E");
  static final Color vendorPrimary = HexColor("#0F766E");
  static final Color secondary = HexColor("#d889a0");
  static  Color white = Colors.white;
  static const Color surface = Color(0xFFF5F5F5);
  static const Color text = Colors.black;
  static const Color transparent = Colors.transparent;
  static const Color hint = Color(0xFF888888);
  static final Color grey10 = HexColor("#EFEFF0");
  static final Color grey1 = HexColor("#7676801F").withValues();
  static final Color grey2 = HexColor("#8E8E93");
  static final Color grey3 = HexColor("#A3A3A3");
  static final Color grey4 = HexColor("#767680");
  static final Color grey5 = HexColor("#3C3C43");
  static final Color grey6 = HexColor("#E0E7ED");
  static final Color grey7 = HexColor("#E2E2E2");
  static final Color grey8 = HexColor("#5A5A5A");

  // Dark Theme
  static  Color darkPrimary = HexColor("#DE3163");
  static  Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static  Color darkText = Colors.white;
  static const Color darkHint = Color(0xFFAAAAAA);

  // Shared
  static const Color grey = Colors.grey;
  static  Color black = HexColor("#000000");
  static  Color black10 = HexColor("#101010");
  static  Color black1 = HexColor("#515151");
  static  Color black2 = HexColor("#D7D7D7");
  static  Color black3 = HexColor("#5D5D5D");
  static  Color black4 = HexColor("#262626");
  static  Color green10 = HexColor("#D7F5EC");
  static  Color green1 = HexColor("#E7FAF8");
  static  Color red1 = HexColor("#FDD0CC");
  static  Color red2 = HexColor("#FFE7EB");
  static  Color red3 = HexColor("#EA193C");
  static const Color success = Colors.green;
  static const Color warning = Colors.orange;
  static const Color danger = Colors.red;
}
