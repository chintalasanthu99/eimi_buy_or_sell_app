
import 'package:eimi_buy_or_sell_app/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../../utils/core/core.dart';

class CustomEmptyScreen extends StatelessWidget {
String title;
String description;
String? lottieFile;
String? imageFile;
double? height;
String? buttonText;
Icon? buttonIcon;
double? topSpace;
Function? onClickButton;
CustomEmptyScreen({super.key, this.height = 140,required this.title,required this.description,this.lottieFile,
  this.buttonText,this.buttonIcon,this.imageFile,this.topSpace,this.onClickButton});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: deviceWidth(context),
        height: height,
        padding: const EdgeInsets.all(10),
        child: Column(


          children: [
            VerticalSpace(height:topSpace!=null?topSpace:deviceWidth(context)/4,),
            lottieFile!=null?Container(
              child: Lottie.asset("$lottieFile",
                  height: 220,
                  repeat: true
              ),
            ):const SizedBox.shrink(),
            imageFile!=null?Container(
              child: Image.asset("$imageFile", height: deviceHeight(context)*0.12,width: deviceHeight(context)*0.12),
            ):const SizedBox.shrink(),
            customThemeText(title, 18,fontWeight: FontWeight.w600,textAlign: TextAlign.center),
            VerticalSpace(height: 16,),
            customThemeText(description, 14,fontWeight: FontWeight.w400,textAlign: TextAlign.center,maxLines: 3),
            Visibility(
              visible: buttonText!=null && buttonText!.isNotEmpty,
              child: Column(
                children: [
                  VerticalSpace(height: deviceHeight(context)*0.01,),
                  FittedBox(
                    child: Container(
                      padding: const EdgeInsets.only(top: 12,bottom: 12,left: 20,right: 20),
                      margin: const EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 10),
                      decoration:  BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          customThemeText("${ buttonText!=null && buttonText!.isNotEmpty?buttonText:""}", 16,fontWeight: FontWeight.w700,color: Colors.white,textAlign: TextAlign.center),
                          HorizontalSpace(width: 8,),
                          Visibility(
                              visible: buttonIcon!=null,
                              child: buttonIcon!=null ?buttonIcon!:SizedBox.shrink()),
                        ],
                      ),
                    ).onTap(() {
                      print("clicked1");
                      if(onClickButton!=null){
                        print("clicked2");
                        onClickButton!();
                    }

                    }),
                  ),
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}