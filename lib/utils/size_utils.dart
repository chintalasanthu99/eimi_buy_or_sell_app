import 'package:flutter/material.dart';

class SizeUtils {
  static const SizedBox height10 = SizedBox(height: 10);
  static const SizedBox height20 = SizedBox(height: 20);
  static const SizedBox height6 = SizedBox(height: 6);
  static const SizedBox height4 = SizedBox(height: 4);
  static const SizedBox width10 = SizedBox(width: 10);
  static const SizedBox width20 = SizedBox(width: 20);
  static const SizedBox width6 = SizedBox(width: 6);
  static const SizedBox width4 = SizedBox(width: 4);
  static const SizedBox width12 = SizedBox(width: 12);

  static const pagePadding = 16.0;
  static const spacingXL = 24.0;
  static const iconXS = 16.0;

  static Widget spacing({double height = 0, double width = 0}) =>
      SizedBox(height: height, width: width);
}
