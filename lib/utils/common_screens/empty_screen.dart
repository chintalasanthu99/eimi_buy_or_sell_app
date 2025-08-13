
import 'package:eimi_buy_or_sell_app/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../../utils/core/core.dart';

class EmptyScreen extends StatelessWidget {
String title;
String description;
String lottieFile;
Color? textColor;
  EmptyScreen({required this.title,required this.description,required this.lottieFile,this.textColor})
      : super();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: deviceWidth(context),
        height: deviceHeight(context),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            VerticalSpace(height: 140,),
            Container(
              child: Lottie.asset("${lottieFile}",
                  height: 220,
                  repeat: true
              ),
            ),
            themeCustomTextHeading("${title}", 18,fontWeight: FontWeight.w600,textAlign: TextAlign.center,color: textColor != null ?textColor!:AppColors.black,maxLines: 2),
            VerticalSpace(height: 16,),
            themeCustomTextHeading("${description}", 14,fontWeight: FontWeight.w400,textAlign: TextAlign.center,color: textColor != null ?textColor!:AppColors.black,maxLines: 2),
          ],
        )
      ),
    );
  }
}