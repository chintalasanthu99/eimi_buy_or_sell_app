
import 'package:Eimi/auth/login_screen.dart';
import 'package:Eimi/auth/signup_screen.dart';
import 'package:Eimi/user_main_home_screen.dart';
import 'package:Eimi/utils/app_colors.dart';
import 'package:Eimi/utils/base_bloc/base_bloc.dart';
import 'package:Eimi/utils/base_bloc/base_state.dart';
import 'package:Eimi/utils/core/core.dart';
import 'package:Eimi/vendor_main_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';


class OnBoardingScreen1 extends StatefulWidget {
  final String? type;
  const OnBoardingScreen1({super.key,this.type});

  @override
  State<OnBoardingScreen1> createState() => _OnBoardingScreen1State();
}

class _OnBoardingScreen1State extends State<OnBoardingScreen1> {
  final BaseBloc _bloc = BaseBloc();
  final ScrollController _scrollController = ScrollController();
  bool isBuyer = true;
  String selectedRole = "buyer";
  _OnBoardingScreen1State();

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
                            if(selectedRole == "buyer"){
                              _navigateToHome();
                            }else if(selectedRole == "seller"){
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
                              VerticalSpace(height: deviceHeight(context)*0.078,),
                              Column(
                                children:  [
                                  //BODY WIDGETS
                                  _buildSelectionCard(
                                      "Want to buy products?",
                                      "Login as a user to browse through different categories of products and contact product owners to own them.",
                                      "assets/images/buyer_image.png","buyer"),
                                  VerticalSpace(height: deviceHeight(context)*0.02,),
                                  _buildSelectionCard(
                                      "Want to sell products?",
                                      "Login as a vendor to sell/list your products without any inconvenience.",
                                      "assets/images/seller_image.png","seller"),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  //BOTTOM WIDGETS
                  buttonWidget()

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  //UI WIDGETS   -> We have to use custom components whatever we have in project.

  Widget _buildSelectionCard(String title,String description,String image,String role){
    final isSelected = selectedRole == role;
    return Card(
      elevation: 4,
      color: AppColors.white,
      child: Stack(
        children: [

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: deviceWidth(context),
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                   borderRadius: BorderRadius.only(topRight: Radius.circular(16),topLeft:  Radius.circular(16)),
                    color: AppColors.green2,
                  ),
                  child: Column(
                    children: [
                      VerticalSpace(height: 10,),
                      Image.asset(image,height: deviceHeight(context)*0.12,width: deviceWidth(context)*0.36,),
                    ],
                  )),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customThemeText(title, 16,fontWeight: FontWeight.w700,color: AppColors.black),
                    VerticalSpace(height: 0,),
                    customThemeText(description, 14,fontWeight: FontWeight.w500,color: AppColors.black)
                  ],
                ),
              ),
          
            ],
          ),
          Align(
            alignment: Alignment.topRight,
              child: Container(
                padding: EdgeInsets.only(right: 12,top: 12),
                child: InkWell(
                  splashColor: AppColors.primary,
                  radius: 30,
                  onTap: (){
                    setState(() {
                      selectedRole = role;
                    });
                  },

                    child: isSelected?Image.asset("assets/images/check.png",height: 20,width: 20,):Image.asset("assets/images/uncheck.png",height: 20,width: 20,)
                ),
              )),
          ]
      ),

      );

  }

  Widget buttonWidget(){
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
        width: double.infinity,
        // height: 50,
        decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(8)),
        child: customThemeText(
            "Continue",16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            textAlign: TextAlign.center
        )
    ).onTap((){
      if(widget.type!=null && widget.type == "login"){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) =>  LoginScreen(role: selectedRole,)),
        );
      }else if(widget.type!=null && widget.type == "signup"){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) =>  SignUpScreen(role: selectedRole,)),
        );
      }

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

  void _navigateToHome() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainHomeScreen()));
  }
  void _navigateToVendorHome() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const VendorMainHomeScreen()));

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
