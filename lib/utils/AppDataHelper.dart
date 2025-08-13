import 'dart:convert';

import 'package:Eimi/utils/shared_pref/shared_preference_constants.dart';
import 'package:Eimi/utils/shared_pref/shared_preference_helper.dart';


class AppDataHelper {

  static String? userId;
  static bool? isLoggedIn;
  static String? accessToken;
  static String? refreshToken;
  static String? email;
  static String? userName;
  static String? mobile;
  static String? profileImage;
  static bool? isAdmin;
  static String? appVersion;
  static String? role;


  static init() async {
    userId = await SharedPreferenceHelper.getString(Preferences.user_id);
    isLoggedIn = await SharedPreferenceHelper.getBool(Preferences.isLoggedIn);
    role = await SharedPreferenceHelper.getString(Preferences.role);
    accessToken = await SharedPreferenceHelper.getString(Preferences.accessToken);
    refreshToken = await SharedPreferenceHelper.getString(Preferences.refreshToken);
    email =await SharedPreferenceHelper.getString(Preferences.email);
    userName =await SharedPreferenceHelper.getString(Preferences.user_name);
    mobile =await SharedPreferenceHelper.getString(Preferences.mobile);
    profileImage =await SharedPreferenceHelper.getString(Preferences.profileImage);
    isAdmin = await SharedPreferenceHelper.getBool(Preferences.isAdmin);
    appVersion = await SharedPreferenceHelper.getString(Preferences.app_version);
  }


  static deleteData(){
    userId = null;
    accessToken = null;
    refreshToken = null;
    email = null;
    userName = null;
    mobile = null;
    profileImage = null;
    isAdmin = null;
    appVersion = null;
    isLoggedIn = null;
    role = null;

  }

}
