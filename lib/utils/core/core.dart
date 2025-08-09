import 'package:eimi_buy_or_sell_app/utils/app_colors.dart';
import 'package:eimi_buy_or_sell_app/utils/text_utils.dart';
import 'package:flutter/material.dart';

export './extend.dart';

class VerticalSpace extends SizedBox {
  VerticalSpace({double height = 8.0}) : super(height: height);
}

class HorizontalSpace extends SizedBox {
  HorizontalSpace({double width = 8.0}) : super(width: width);
}

BoxDecoration ShadowboxDecoration(
    ) {
  return BoxDecoration (
      color:  Color(0xfff6f8fb),
      borderRadius:  BorderRadius.circular(4*fem),
      boxShadow: [
        BoxShadow(color: Colors.grey,offset: Offset.fromDirection(2),blurRadius: 2)
      ]

  );
}

BoxDecoration boxDecoration(
  color,
  borderWidth,
  borderRadius,
  isFill,
) {
  return BoxDecoration(
      border: Border.all(color: color, width: borderWidth),
      borderRadius: BorderRadius.circular(borderRadius),
      color: isFill ? color : null);
}
BoxDecoration boxDecorationWithBorder(
    color,
    borderWidth,
    borderRadius,
    borderColor,
    ) {
  return BoxDecoration(
      border: Border.all(color: borderColor, width: borderWidth),
      borderRadius: BorderRadius.circular(borderRadius),
      color: color);
}

BoxDecoration boxDecorationTopLeft(
  color,
  borderRadius,
) {
  return BoxDecoration(
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(borderRadius),
        topRight: Radius.circular(borderRadius)),
    color: color,
  );
}

showError(context, errorMessage) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        duration: Duration(milliseconds: 2000),
        content: Text(errorMessage),
        backgroundColor: AppColors.primary),
  );
}

deviceWidth(context) => MediaQuery.of(context).size.width;
deviceHeight(context) => MediaQuery.of(context).size.height;
devicefemWidth(context) {
  femwidth = MediaQuery.of(context).size.width;
}
double femwidth=0;
double baseWidth = 359;
double fem = femwidth / baseWidth;
double ffem = fem * 0.97;
textTitle(text,
    {Color color = Colors.black,
    double fontSize = 14.0,
    FontWeight fontWeight = FontWeight.normal,
    textAlign= TextAlign.start}) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    ),
  );
}

Text textLarge(text,
    {Color color = Colors.black,
    FontWeight fontWeight = FontWeight.normal,
    textAlign= TextAlign.start}) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
      fontSize: 18.0,
      color: color,
      fontWeight: fontWeight,
    ),
  );
}

Text textMedium(text,
    {Color color = Colors.black,
    FontWeight fontWeight = FontWeight.normal,
    textAlign = TextAlign.start}) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(fontSize: 16.0, color: color, fontWeight: fontWeight),
  );
}

Text textSmall(text,
    {Color color = Colors.black,
    FontWeight fontWeight = FontWeight.normal,
    textAlign= TextAlign.start}) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
      fontSize: 14.0,
      color: color,
      fontWeight: fontWeight,
    ),
  );
}

Text textCustom(text,
    double fontSize,
    {Color color = Colors.black,
      maxLines = 1,
      overflow = TextOverflow.ellipsis,
    FontWeight fontWeight = FontWeight.normal,
      String fontFamily = "DM Sans",
    textAlign= TextAlign.start,textStyle= TextStyle}) {
  return Text(
    text,
    maxLines: maxLines,
    textAlign: textAlign,
    style: TextStyle(
      fontSize: fontSize,
      color: color,
      overflow: overflow,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
    ),
  );
}

Text themeCustomText(text,
    double fontSize,
    {Color color = Colors.black,
      FontWeight fontWeight = FontWeight.normal,
      textAlign= TextAlign.start,textStyle= TextStyle}) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextUtils.safeGoogleFont (
      decoration: TextDecoration.none,
      fontWeight: fontWeight,
      fontSize:fontSize,
      'DM Sans',
      color: color,
    ),
  );
}

Text customThemeText(text,
    double fontSize,
    {Color color = Colors.black,
      int? maxLines,
       String fontFamily = "Manrope",
      TextOverflow? overFlow ,
      bool? softWrap,
      FontWeight fontWeight = FontWeight.normal,
      FontStyle fontStyle = FontStyle.normal,
      TextDecoration underLine = TextDecoration.none,
      Key? key,
      textAlign= TextAlign.start,textStyle= TextStyle}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: maxLines,
    softWrap: softWrap,
    key:key,
    style: TextUtils.safeGoogleFont (
      decoration: underLine,
      fontWeight: fontWeight,
      fontSize:fontSize,
      fontFamily,
      color: color,

      textStyle: TextStyle(
       overflow: overFlow,
        fontStyle: fontStyle,

      )
    ),
  );
}
Text themeCustomTextHeading(text,
    double fontSize,
    {Color color = Colors.black,
      int maxLines = 1,
      TextOverflow overFlow = TextOverflow.ellipsis,
      FontWeight fontWeight = FontWeight.normal,
      textAlign= TextAlign.start,textStyle= TextStyle}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: maxLines,
    style: TextUtils.safeGoogleFont (
        decoration: TextDecoration.none,
        fontWeight: fontWeight,
        fontSize:fontSize,
        'Avenir',
        color: color,
        textStyle: TextStyle(
          overflow: overFlow,
        )
    ),
  );
}



Widget horizontalLine(context, {double? height,Color? color,}) => Container(
      height: height?? 1,
      width: deviceWidth(context),
      color: color ?? AppColors.primary,
    );
Widget verticalLine(context, double height,{Color? color,double? width}) => Container(
      width: width ?? 1,
      height: height,
      color:color?? AppColors.primary,
    );


extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

String allWordsCapitilize(String str) {
  // return str.toLowerCase().split(' ').map((word) {
  //   String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
  //   return word[0].toUpperCase() + leftText;
  // }).join(' ');
  return str.replaceAllMapped(RegExp(r'^([a-z])|[A-Z]'),
          (Match m) => m[1] == null ? "${m[0]}":m[1]!.toUpperCase());
}
String camelToSentence(String text) {
  return text.replaceAllMapped(RegExp(r'^([a-z])|[A-Z]'),
          (Match m) => m[1] == null ? "${m[0]}":m[1]!.toUpperCase());
}
String camelCapitalize(String str) {
  if (str.isNotEmpty) {
    List second = [];
    str.replaceAll("", "");
    final nameArray = str.toLowerCase().split(" ");
    for (var e in nameArray) {
      if (e.length > 1) second.add(e);
    }
    return second.map((word) {
      String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
      return word[0].toUpperCase() + leftText;
    }).join(' ');
  } else {
    return str;
  }
}