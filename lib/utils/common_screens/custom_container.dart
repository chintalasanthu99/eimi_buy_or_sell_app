
import 'package:eimi_buy_or_sell_app/utils/app_colors.dart';
import 'package:eimi_buy_or_sell_app/utils/app_strings.dart';
import 'package:eimi_buy_or_sell_app/utils/base_bloc/base_state.dart';
import 'package:eimi_buy_or_sell_app/utils/common_screens/errorscreen.dart';
import 'package:eimi_buy_or_sell_app/utils/common_screens/loader.dart';
import 'package:eimi_buy_or_sell_app/utils/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


//
class CustomContainer extends StatelessWidget {
  final Widget child;
  final BaseState state;
  Function onRefresh;
  Color? statusBarColor;

  CustomContainer(this.child,this.state,this.onRefresh, {Key? key,this.statusBarColor,}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    // Determine if the status bar color is dark or light
    statusBarColor = statusBarColor!=null ?statusBarColor!:AppColors.white;
    bool isDark = ThemeData.estimateBrightnessForColor(statusBarColor!) == Brightness.dark;

    // Set the SystemUiOverlayStyle based on the brightness of the statusBarColor
    final SystemUiOverlayStyle overlayStyle = isDark
        ? SystemUiOverlayStyle.light.copyWith(statusBarColor: statusBarColor)
        : SystemUiOverlayStyle.dark.copyWith(statusBarColor: statusBarColor);

    Widget result = GestureDetector(
        onTap: (){
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child:  AnnotatedRegion<SystemUiOverlayStyle>(
          value: overlayStyle,
          child: Container(
              height: deviceHeight(context),
              color: AppColors.white,
              child: Stack(children: <Widget>[
                RefreshIndicator(onRefresh:()=>onRefresh(),color: AppColors.primary,
                    child: child),
                Visibility(visible: state is Loading, child: Loader()),
                Visibility(
                    visible: state is ScreenError,
                    child: ErrorScreen(state is ScreenError ? getErrorMessage(state as ScreenError) : "")),
              ])),
        )
    ) ;
    return result;
  }

  String getErrorMessage(ScreenError state) {
    if (state.errorId == 1) {
      return AppStrings.NO_NETWORK;
    }
    return AppStrings.SOMETHING_WENT_WRONG;
  }
}
