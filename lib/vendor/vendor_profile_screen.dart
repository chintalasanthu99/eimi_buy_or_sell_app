import 'package:Eimi/utils/app_colors.dart';
import 'package:Eimi/utils/base_bloc/base_state.dart';
import 'package:Eimi/utils/core/core.dart';
import 'package:Eimi/vendor/edit_vendor_profile_screen.dart';
import 'package:Eimi/vendor/vendor_booking.dart';
import 'package:Eimi/vendor/vendor_home/vendor_home_bloc/vendor_home_bloc.dart';
import 'package:Eimi/vendor/vendor_notificatons_screen.dart';
import 'package:Eimi/vendor/vendor_review_screen.dart';
import 'package:Eimi/vendor/vendor_settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';



class VendorProfileScreen extends StatefulWidget {
  Function(int)? onBackClick;
   VendorProfileScreen({super.key,this.onBackClick});

  @override
  State<VendorProfileScreen> createState() => _VendorProfileScreenState();
}

class _VendorProfileScreenState extends State<VendorProfileScreen> {
  final VendorHomeBloc _bloc = VendorHomeBloc();
  final ScrollController _scrollController = ScrollController();
  _VendorProfileScreenState();

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
    return BlocListener<VendorHomeBloc, BaseState>(listener: (context, state) async {
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
    }, child: BlocBuilder<VendorHomeBloc, BaseState>(
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
                              VerticalSpace(height: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:  [
                                  //BODY WIDGETS
                                  customThemeText("Profile", 20,fontWeight: FontWeight.w700,color: AppColors.black),
                                  VerticalSpace(),
                                  Container(
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 36,
                                          backgroundImage: AssetImage("assets/images/profile.png",),
                                        ),
                                        HorizontalSpace(),
                                        Column(
                                          children: [
                                            customThemeText("Santhosh", 18,fontWeight: FontWeight.w700,color: AppColors.black),
                                            customThemeText("Electronics", 14,fontWeight: FontWeight.w600,color: AppColors.black3),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                  Container(
                                      padding: EdgeInsets.symmetric(vertical: 10),
                                      child: horizontalLine(context,color: AppColors.grey6)),
                                  customThemeText("My Activity", 18,fontWeight: FontWeight.w700,color: AppColors.black),
                                  listWidget("assets/images/list_icon.png","My Listings"),
                                  listWidget("assets/images/list_icon.png","Notifications"),
                                  listWidget("assets/images/list_icon.png","Appointments"),
                                  Container(
                                      padding: EdgeInsets.symmetric(vertical: 10),
                                      child: horizontalLine(context,color: AppColors.grey6)),
                                  customThemeText("Account Settings", 18,fontWeight: FontWeight.w700,color: AppColors.black),
                                  listWidget("assets/images/list_icon.png","Edit profile"),
                                  listWidget("assets/images/list_icon.png","Language & Region"),
                                  listWidget("assets/images/list_icon.png","Settings"),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                      child: horizontalLine(context,color: AppColors.grey6)),
                                  customThemeText("Support And Info", 18,fontWeight: FontWeight.w700,color: AppColors.black),
                                  listWidget("assets/images/list_icon.png","Help And Support"),
                                  listWidget("assets/images/list_icon.png","Terms And Conditions"),
                                  listWidget("assets/images/list_icon.png","FAQs"),
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
  Widget listWidget(String image,String title,{String? action}){
    return InkWell(
      onTap: (){
         if(title=="My Listings"){
           widget.onBackClick!(1);

        } else if(title=="Appointments"){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const VendorBookingsScreen()),
          );
        }else if(title=="Notifications"){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const VendorNotificationScreen()),
          );
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(image,color: AppColors.black,height: 18,width: 18,),
                HorizontalSpace(),
                customThemeText(title, 15,fontWeight: FontWeight.w400,color: AppColors.black),
              ],
            ),
            Icon(Icons.arrow_forward_ios_rounded,color: AppColors.black1,size: 18,)
          ],
        ),
      )
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
