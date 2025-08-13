
import 'package:Eimi/utils/S3Constants.dart';
import 'package:Eimi/utils/app_strings.dart';
import 'package:Eimi/utils/app_theme.dart';
import 'package:Eimi/utils/flavour_config.dart';
import 'package:Eimi/utils/network/DataModule.dart';
import 'package:Eimi/utils/route_constants.dart';
import 'package:Eimi/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DataModule().init();
  FlavorConfig(
      appName: AppStrings.devEnv,
      baseUrl: AppStrings.devURL,
      appId: "",
      packageName: "",
      s3constants: S3DevConstants()
  );

  var config =  MaterialApp(
    title: 'Eimi',
    debugShowCheckedModeBanner: false,
    theme: AppTheme.lightTheme,
    darkTheme: AppTheme.darkTheme,
    themeMode: ThemeMode.light,
      initialRoute: RouteStrings.SPLASH,
      routes: RoutesData().getCommonRoutes(),
    builder: (context, child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
        child: child!,
      );
    },
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(config);
  });


}

