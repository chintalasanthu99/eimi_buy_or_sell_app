import 'package:Eimi/auth/auth_bloc/auth_bloc.dart';
import 'package:Eimi/auth/auth_bloc/auth_event.dart';
import 'package:Eimi/auth/modles/login_request.dart';
import 'package:Eimi/user/models/user_model.dart';
import 'package:Eimi/user_main_home_screen.dart';
import 'package:Eimi/utils/app_colors.dart';
import 'package:Eimi/utils/base_bloc/base_bloc.dart';
import 'package:Eimi/utils/base_bloc/base_state.dart';
import 'package:Eimi/utils/core/core.dart';
import 'package:Eimi/vendor/models/vendor_model.dart';
import 'package:Eimi/vendor_main_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../utils/app_strings.dart';




enum Role { buyer, seller }


class LoginScreen extends StatefulWidget {
  final String? role;
   const LoginScreen({super.key,this.role});

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
  Role _role = Role.buyer;


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
            if (user.role?.toLowerCase() == 'user') {
              _navigateToHome();
            }

          }
        }else if(state.event == "VendorLogInEvent"){
          if(state.data!=null){
            vendor = state.data;
            print("success");
            if (vendor.role?.toLowerCase() == 'vendor')  {
              _navigateToVendorHome();
            }

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
                  Container(
                    padding: EdgeInsets.only(left: 16, top: 10,right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back)),
                        InkWell(
                          onTap: (){
                           if(_role == Role.buyer){
                             _navigateToHome();
                           }else if(_role == Role.seller){
                             _navigateToVendorHome();
                           }
                          },
                          child: customThemeText(
                              "Skip",16,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                              textAlign: TextAlign.right

                          ),
                        )

                      ],
                    ),
                  ),


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
                              VerticalSpace(height: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:  [
                                  //BODY WIDGETS
                                  VerticalSpace(height: 20),
                                  customThemeText(
                                    "Welcome Back ! \nSign In To Continue",24,
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  VerticalSpace(height: 36),
                                  customThemeText(
                                    "Your Mobile Number",16,
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w700,

                                  ),
                                  VerticalSpace(height: 10),
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                          border: Border.all(width: 0.5,color: AppColors.black)
                                        ),
                                        height: deviceHeight(context)*0.056,
                                        padding: EdgeInsets.only(left: 10,top: 10,right: 10),
                                        child: customThemeText("+91", 14,textAlign: TextAlign.center,fontWeight: FontWeight.w700),
                                      ),
                                      HorizontalSpace(),
                                      Expanded(
                                        child: TextFormField(
                                          controller: _mobileController,
                                          style: TextStyle(color: AppColors.black),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                                            hintText: "Enter your mobile number",
                                            hintStyle: TextStyle(color: AppColors.grey9,fontSize: 16),
                                            filled: true,
                                            fillColor: Colors.transparent,
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(8),
                                              borderSide: BorderSide(color: AppColors.black2),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(8),
                                              borderSide: BorderSide(color: AppColors.primary, width: 1),
                                            ),
                                          ),
                                          keyboardType: TextInputType.phone,
                                        ),
                                      ),
                                    ],
                                  ),
                                  VerticalSpace(height: 20,),
                                  TextField(
                                    obscureText: true,
                                    controller: _passwordController,
                                    style: TextStyle(color: AppColors.black),

                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(horizontal: 30,vertical: 6),
                                      hintText: "Enter your password",
                                      hintStyle: TextStyle(color: AppColors.grey9,fontSize: 16),
                                      suffixIcon: Icon(Icons.visibility, color: AppColors.primary),
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(color: AppColors.black2,width: 0.5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(color: AppColors.primary, width: 0.5),
                                      ),
                                    ),
                                  ),
                                  VerticalSpace(height: 10),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: customThemeText(
                                      "Forgot Password?",16,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                      textAlign: TextAlign.right

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
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        _callSignApi();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: customThemeText(
                        "Sign In",16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  //UI WIDGETS   -> We have to use custom components whatever we have in project.
  Widget _buildRoleToggle() {
    return LayoutBuilder(
      builder: (context, constraints) {
        const double h = 44.0;
        const double pad = 3.0;
        final double w = constraints.maxWidth;
        final double segmentW = (w - pad * 2) / 2.4; // exact half

        return Semantics(
          button: true,
          label: 'Role toggle',
          value: _role == Role.buyer ? 'Buyer' : 'Seller',
          hint: 'Tap to switch',
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),

            // decoration: BoxDecoration(
            //   color: AppColors.primary,
            //   borderRadius: BorderRadius.circular(16),
            //   border: Border.all(width: 0.5, color: AppColors.black),
            // ),

            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: _toggleRole,
              onDoubleTap: _toggleRole,
              onLongPress: _toggleRole,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 00),
                height: h,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(width: 0.5, color: AppColors.black),
                ),
                child: Stack(
                  children: [
                    AnimatedAlign(
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOut,
                      alignment: _role == Role.buyer
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Container(
                        height: h - pad * 3,
                        width: segmentW,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    // Labels
                    Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: customThemeText(
                              "Buyer",
                              16,
                              color: _role == Role.buyer
                                  ? AppColors.primary
                                  : AppColors.white,
                              fontWeight: FontWeight.w600,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: customThemeText(
                              "Seller",
                              16,
                              color: _role == Role.seller
                                  ? AppColors.primary
                                  : AppColors.white,
                              fontWeight: FontWeight.w600,
                              textAlign: TextAlign.center,
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
        );
      },
    );
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

  void _toggleRole() {
    setState(() {
      _role = _role == Role.buyer ? Role.seller : Role.buyer;
    });
  }


  void _callSignApi() {
    final mobile = _mobileController.text.trim();
    final password = _passwordController.text.trim();

    if (mobile.isEmpty || password.isEmpty) {
      _showSnackBar("PLease enter the details");
      return;
    }
    logInRequest.mobile = mobile;
    logInRequest.password = password;
    _bloc.add(LogInEvent(logInRequest));
    // _bloc.add(VendorLogInEvent(logInRequest));
  }

  void _navigateToHome() {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainHomeScreen()));
  }
  void _navigateToVendorHome() {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const VendorMainHomeScreen()));

  }

  //API CALLS
  Future<void> initPlatformState() async {
    if (!mounted) return;
  }


}

