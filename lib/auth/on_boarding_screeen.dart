
import 'package:eimi_buy_or_sell_app/auth/login_screen.dart';
import 'package:eimi_buy_or_sell_app/auth/on_boarding_screen1.dart';
import 'package:eimi_buy_or_sell_app/utils/app_colors.dart';
import 'package:eimi_buy_or_sell_app/utils/base_bloc/base_bloc.dart';
import 'package:eimi_buy_or_sell_app/utils/base_bloc/base_state.dart';
import 'package:eimi_buy_or_sell_app/utils/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';


class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final BaseBloc _bloc = BaseBloc();
  final ScrollController _scrollController = ScrollController();
  _OnBoardingScreenState();

  @override
  void initState() {
    initPlatformState();
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
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

  Widget buildUI(state, context) {
    final height = deviceHeight(context);
    final width = deviceWidth(context);

    return Container(
      color: AppColors.white,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: height * 0.36,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/bg_onboarding.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // Foreground curved container
            Positioned(
              top: height * 0.30,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                        child: Container(
                          child:  SingleChildScrollView(
                        controller: _scrollController,
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              VerticalSpace(height: deviceHeight(context)*0.06,),
                              Image.asset(
                                "assets/images/logo.png",
                                height: height * 0.08,
                              ),
                              VerticalSpace(height: deviceHeight(context)*0.03,),
                              customThemeText(
                                "Join EIMI and start buying or selling products with ease.",20,fontWeight: FontWeight.w600,
                                textAlign: TextAlign.center,
                              ),
                              VerticalSpace(height: deviceHeight(context)*0.08,),
                              buttonWidget(),
                              VerticalSpace(height: 20),
                              buttonWidgetWithoutBg(),
                              VerticalSpace(height: 10),
                            ],
                          ),

                        ),
                      ),
                    )),

                    Container(
                      child: Column(
                        children: [
                          Text.rich(
                            TextSpan(
                              text: "By continuing, you agree to our ",
                              children: [
                                TextSpan(
                                  text: "Terms Of Service",
                                  style: TextStyle(color: Colors.blue),
                                ),
                                TextSpan(text: " & "),
                                TextSpan(
                                  text: "Privacy Policy",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          VerticalSpace(height: 20,)
                        ],
                      ),
                    ),




                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }



  //UI WIDGETS   -> We have to use custom components whatever we have in project.
  Widget buttonWidget(){
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
      width: double.infinity,
      // height: 50,
      decoration: BoxDecoration(
        color: AppColors.primary,
            borderRadius: BorderRadius.circular(16)),
      child: customThemeText(
        "Sign In",16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        textAlign: TextAlign.center
      )
    ).onTap((){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const OnBoardingScreen1(type:"login")),
      );
    });
  }

  Widget buttonWidgetWithoutBg(){
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
        width: double.infinity,
        // height: 50,
        decoration: BoxDecoration(
            // color: AppColors.primary,
          border: Border.all(width: 1,color: AppColors.primary),
            borderRadius: BorderRadius.circular(16)),
        child: customThemeText(
            "Create Account",16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            textAlign: TextAlign.center
        )
    ).onTap((){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const OnBoardingScreen1(type: "signup",)),
      );
    });
  }



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


}
