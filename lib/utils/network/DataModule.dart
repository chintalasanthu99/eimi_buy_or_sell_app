
import 'dart:io';

import 'package:eimi_buy_or_sell_app/utils/AppDataHelper.dart';
import 'package:eimi_buy_or_sell_app/utils/app_log.dart';
import 'package:eimi_buy_or_sell_app/utils/sync_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../shared_pref/shared_preference_helper.dart';
import 'package:sqflite/sqflite.dart';



class DataModule {
  //initialize Crashlytics, Db, Preferences and AppDataHelper
  Future<bool> init() async {
    //Crashlytics.instance.enableInDevMode = true;
    // Pass all uncaught errors from the framework to Crashlytics.
    //FlutterError.onError = Crashlytics.instance.recordFlutterError;
    await initPreferences();
    // await initDataBase();
    await initDataHelper();
    await initConnectivity();
    // await initFirebase();
    // await NotificationHandler().initializeFcmNotification();
    return true;
  }

  initPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    SharedPreferenceHelper.init(preferences);
  }

  initDataHelper() async{
    await AppDataHelper.init();
  }


  // initDataBase() async {
  //   Database database = await DatabaseCore().createDatabase();
  //   DatabaseHelper.init(database);
  // }

  initConnectivity() async {
    SyncHelper.getInstance().initConnectivity();
  }
  // initFirebase() async {
  //   String? id = await FirebaseInstallations.id;
  //   debugPrint("FirebaseInstallations ID::${id}");
  //   // Initialize Firebase In-App Messaging
  //   await FirebaseInAppMessaging.instance.setAutomaticDataCollectionEnabled(true);
  //   await FirebaseInAppMessaging.instance.app.setAutomaticDataCollectionEnabled(true);
  //   FirebaseInAppMessaging.instance.setAutomaticDataCollectionEnabled(true);
  // }




  clearData() async {
    await SharedPreferenceHelper.delete();
    // DatabaseCore().deleteDB();
    AppDataHelper.deleteData();
    AppLog.d("Db Deleted");
  }
}
