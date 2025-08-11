import 'dart:async';

import 'package:eimi_buy_or_sell_app/utils/app_colors.dart';
import 'package:eimi_buy_or_sell_app/utils/base_bloc/base_state.dart';
import 'package:eimi_buy_or_sell_app/utils/core/core.dart';
import 'package:eimi_buy_or_sell_app/utils/shared_pref/shared_preference_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/base_bloc/base_bloc.dart';
import '../utils/route_constants.dart';
import '../utils/shared_pref/shared_preference_helper.dart';





class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  final BaseBloc _bloc = BaseBloc();
  final ScrollController _scrollController = ScrollController();
  bool isLoggedIn = false;
  bool onboarded = false;
  String role = "";

  late final AnimationController _c;
  late final Animation<double> _fade;
  late final Animation<double> _scale;
  late final Animation<Offset> _bottomSlide;
  _SplashScreenState();


  @override
  void initState() {
    initPlatformState();
    _checkLoginStatus();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fade = CurvedAnimation(parent: _c, curve: Curves.easeOut);
    _scale = Tween<double>(begin: 0.85, end: 1.0)
        .animate(CurvedAnimation(parent: _c, curve: Curves.easeOutBack));

    _bottomSlide = Tween<Offset>(begin: const Offset(0, 0.4), end: Offset.zero)
        .animate(CurvedAnimation(parent: _c, curve: Curves.easeOutCubic));

    // kick it off
    _c.forward();

    super.initState();
  }


  @override
  void dispose() {
    _bloc.close();
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocProvider(
        create: (_) => _bloc,
        child: buildPage(),
      ),
    );
  }


  Widget buildPage() {
    return BlocListener<BaseBloc, BaseState>(listener: (context, state) async {
      if (state is BaseError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              duration: Duration(milliseconds: 2000),
              content: customThemeText(state.errorMessage,14,fontWeight: FontWeight.w600,color: Colors.white),
              backgroundColor: AppColors.primary),
        );
      } else if (state is DataLoaded) {
        //ADD YOUR FUNCTIONALITY
      }
    }, child: BlocBuilder<BaseBloc, BaseState>(
      bloc: _bloc,
      builder: (context, state) {
        return Center(
          child: buildUI(state,context),
        );
      },
    ));
  }

  @override
  Widget buildUI(BaseState state, BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceHeight = size.height;
    final deviceWidth = size.width;

    return Container(
      color: AppColors.primary, // your color
      child: SafeArea(
        top: true,
        bottom: false,
        child: Stack(
          children: [
            // absolute center logo
            Positioned.fill(
              child: Align(
                alignment: const Alignment(0, -0.22),
                child: FadeTransition(
                  opacity: _fade,
                  child: ScaleTransition(
                    scale: _scale,
                    child: Image.asset(
                      "assets/images/logo.png",
                      height: deviceHeight * 0.09,
                    ),
                  ),
                ),
              ),
            ),

            // bottom artwork slides up
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SlideTransition(
                position: _bottomSlide,
                child: Container(
                  height: deviceHeight * 0.30,
                  width: deviceWidth,
                  decoration: const BoxDecoration(
                    // keep background same as screen so it blends
                    image: DecorationImage(
                      image: AssetImage("assets/images/splash.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }




  //UI WIDGETS   -> We have to use custom components whatever we have in project.




  //FUNCTIONALITY
  void _showToastBar(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 6,
        backgroundColor : AppColors.primary,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: customThemeText(
            message,
            14,
            textAlign: TextAlign.center,fontWeight: FontWeight.w600,color: Colors.white
        ),
        backgroundColor: AppColors.primary,
        // behavior: SnackBarBehavior.floating,
        // elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
      ),
    );
  }



  Future<void> onRefresh()async {
    bool data = false;
    // WRITE YOUR REFRESH LOGIC
  }

  //API CALLS
  Future<void> initPlatformState() async {
    if (!mounted) return;
  }

  void _checkLoginStatus() async {
    isLoggedIn = await SharedPreferenceHelper.getBool(Preferences.isLoggedIn) ?? false;
    onboarded = await SharedPreferenceHelper.getBool(Preferences.onboarded) ?? false;
    role = await SharedPreferenceHelper.getString(Preferences.role) ?? "";
    Timer(Duration(seconds: 2), () {
      if (isLoggedIn) {
        if(role.isNotEmpty && role.toLowerCase() == "user"){
          Navigator.pushReplacementNamed(context, RouteStrings.USER_HOMEPAGE_MAIN);
        } else if(role.isNotEmpty && role.toLowerCase() == "vendor"){
          Navigator.pushReplacementNamed(context, RouteStrings.VENDOR_HOMEPAGE_MAIN);
        }
         // example
      } else {
        if(onboarded){
          Navigator.pushReplacementNamed(context, RouteStrings.SIGNIN);
        }else{
          Navigator.pushReplacementNamed(context, RouteStrings.ONBOARDING);
        }

      }
    });

  }


}
