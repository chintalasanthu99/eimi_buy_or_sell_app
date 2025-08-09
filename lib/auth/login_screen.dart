import 'package:eimi_buy_or_sell_app/auth/auth_bloc/auth_bloc.dart';
import 'package:eimi_buy_or_sell_app/auth/auth_bloc/auth_event.dart';
import 'package:eimi_buy_or_sell_app/auth/modles/login_request.dart';
import 'package:eimi_buy_or_sell_app/user/models/user_model.dart';
import 'package:eimi_buy_or_sell_app/user_main_home_screen.dart';
import 'package:eimi_buy_or_sell_app/utils/app_colors.dart';
import 'package:eimi_buy_or_sell_app/utils/base_bloc/base_bloc.dart';
import 'package:eimi_buy_or_sell_app/utils/base_bloc/base_state.dart';
import 'package:eimi_buy_or_sell_app/utils/core/core.dart';
import 'package:eimi_buy_or_sell_app/vendor/models/vendor_model.dart';
import 'package:eimi_buy_or_sell_app/vendor_main_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../utils/app_strings.dart';







class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthBloc _bloc = AuthBloc();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  User user = User();
  VendorModel vendor = VendorModel();
  LogInRequest logInRequest = LogInRequest();


  _LoginScreenState();

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
    return BlocListener<AuthBloc, BaseState>(listener: (context, state) async {
      if (state is BaseError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              duration: Duration(milliseconds: 2000),
              content: customThemeText(state.errorMessage,14,fontWeight: FontWeight.w600,color: Colors.white),
              backgroundColor: AppColors.primary),
        );
      } else if (state is DataLoaded) {
        //ADD YOUR FUNCTIONALITY
        if(state.event == "LogInEvent"){
          if(state.data!=null){
            user = state.data;
            print("success");
            _navigateToHome();
          }
        }else if(state.event == "VendorLogInEvent"){
          if(state.data!=null){
            vendor = state.data;
            print("success");
            _navigateToVendorHome();
          }
        }

      }
    }, child: BlocBuilder<AuthBloc, BaseState>(
      bloc: _bloc,
      builder: (context, state) {
        return Center(
          child: buildUI(state,context),
        );
      },
    ));
  }

  Widget buildUI(state, context) {
    return Container(
      color: AppColors.white,
      child: SafeArea(
        top: true,
        child: Stack(
          children: <Widget>[
            Container(
              color: AppColors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  //APP BAR

                  //BODY
                  Expanded(
                    child: Container(
                      color: AppColors.white,
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Container(
                          margin:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              VerticalSpace(height: deviceHeight(context)*0.10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:  [
                                  //BODY WIDGETS
                                  SizedBox(height: 12),
                                  Center(
                                    child: Column(
                                      children: [
                                        SizedBox(height: 24),
                                        Text(
                                          "Welcome Back",
                                          style: TextStyle(
                                            color: AppColors.black,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 32,
                                          ),
                                        ),
                                        SizedBox(height: 12),
                                        Text(
                                          "Sign in to your buyer account",
                                          style: TextStyle(
                                            color: AppColors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 36),
                                  Text(
                                    "Mobile Number",
                                    style: TextStyle(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  TextFormField(
                                    controller: _mobileController,
                                    style: TextStyle(color: AppColors.black),
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.phone, color: AppColors.black),
                                      hintText: "Enter your mobile number",
                                      hintStyle: TextStyle(color: AppColors.black),
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(color: AppColors.black),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(color: AppColors.black, width: 2),
                                      ),
                                    ),
                                    keyboardType: TextInputType.phone,
                                  ),
                                  SizedBox(height: 24),
                                  Text(
                                    "Password",
                                    style: TextStyle(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  TextField(
                                    obscureText: true,
                                    controller: _passwordController,
                                    style: TextStyle(color: AppColors.black),
                                    decoration: InputDecoration(
                                      hintText: "Enter your password",
                                      hintStyle: TextStyle(color: AppColors.black),
                                      suffixIcon: Icon(Icons.visibility, color: AppColors.black),
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(color: AppColors.black),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(color: AppColors.black, width: 2),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 32),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _callSignApi();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: Text(
                                        "Sign In",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 24),
                                  Center(
                                    child: TextButton(
                                      onPressed: () {
                                        // Handle forgot password
                                      },
                                      child: Text(
                                        "Forgot Password?",
                                        style: TextStyle(
                                          color: AppColors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  Center(
                                    child: RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                          color: AppColors.black,
                                          fontSize: 15,
                                        ),
                                        children: [
                                          TextSpan(text: "Don't have an account? "),
                                          TextSpan(
                                            text: "Sign up as buyer",
                                            style: TextStyle(
                                              color: AppColors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            // Add recognizer if needed for tap
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  //BOTTOM WIDGETS

                ],
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



  void _callSignApi() {
    final mobile = _mobileController.text.trim();
    final password = _passwordController.text.trim();

    if (mobile.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.pleaseEnterEmailPassword)),
      );
      return;
    }
    logInRequest.mobile = mobile;
    logInRequest.password = password;
    _bloc.add(LogInEvent(logInRequest));
    // _bloc.add(VendorLogInEvent(logInRequest));
  }

  void _navigateToHome() {
    if (user.role?.toLowerCase() == 'user') {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MainHomeScreen()),
            (route) => false,
      );
    }
  }
  void _navigateToVendorHome() {
    if (vendor.role?.toLowerCase() == 'vendor')  {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const VendorMainHomeScreen()),
            (route) => false,
      );
    }
  }

  //API CALLS
  Future<void> initPlatformState() async {
    if (!mounted) return;
  }


}

