import 'package:eimi_buy_or_sell_app/auth/on_boarding_screeen.dart';
import 'package:eimi_buy_or_sell_app/auth/splash_screen.dart';
import 'package:eimi_buy_or_sell_app/user_main_home_screen.dart';
import 'package:eimi_buy_or_sell_app/utils/route_constants.dart';
import 'package:eimi_buy_or_sell_app/vendor_main_home_screen.dart';
import 'package:flutter/widgets.dart';

import '../auth/login_screen.dart';


class RoutesData {

  Map<String, WidgetBuilder> getCommonRoutes() {
    return  {
      RouteStrings.SPLASH : (context) => SplashScreen(),
      RouteStrings.ONBOARDING : (context) => OnBoardingScreen(),
      RouteStrings.SIGNIN : (context) => LoginScreen(),
      RouteStrings.USER_HOMEPAGE_MAIN : (context) => MainHomeScreen(),
      RouteStrings.VENDOR_HOMEPAGE_MAIN : (context) => VendorMainHomeScreen(),

    };
  }
}