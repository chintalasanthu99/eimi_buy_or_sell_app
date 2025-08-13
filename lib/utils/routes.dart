import 'package:Eimi/auth/on_boarding_screeen.dart';
import 'package:Eimi/auth/splash_screen.dart';
import 'package:Eimi/user_main_home_screen.dart';
import 'package:Eimi/utils/route_constants.dart';
import 'package:Eimi/vendor_main_home_screen.dart';
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