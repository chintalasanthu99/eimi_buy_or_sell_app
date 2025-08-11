import 'package:eimi_buy_or_sell_app/utils/app_colors.dart';
import 'package:eimi_buy_or_sell_app/utils/base_bloc/base_bloc.dart';
import 'package:eimi_buy_or_sell_app/utils/base_bloc/base_state.dart';
import 'package:eimi_buy_or_sell_app/utils/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserBookingsScreen extends StatefulWidget {
  Function(int)? onBackClick;
   UserBookingsScreen({super.key,this.onBackClick});

  @override
  State<UserBookingsScreen> createState() => _UserBookingsScreenState();
}

class _UserBookingsScreenState extends State<UserBookingsScreen> {
  final BaseBloc _bloc = BaseBloc();
  final ScrollController _scrollController = ScrollController();
  _UserBookingsScreenState();

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
                              VerticalSpace(height:10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:  [
                                  //BODY WIDGETS
                                  customThemeText("Bookings", 16,fontWeight: FontWeight.w700,color: AppColors.black),
                                  VerticalSpace(height: 16,),
                                  _buildUserBookingList(context),
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
  Widget _buildUserBookingList(BuildContext context) {
    return ListView.builder(
      itemCount: 3, // replace with your bookingList.length
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, i) {
        return Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(width: 1, color: AppColors.black2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Time slot
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 20, color: AppColors.black),
                      SizedBox(width: 6),
                      customThemeText("9:30 AM to 10:00 AM", 16,
                          fontWeight: FontWeight.w700, color: AppColors.black10),
                    ],
                  ),
                  SizedBox(height: 8),
                  // Address
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: AppColors.black1),
                      SizedBox(width: 6),
                      Expanded(
                        child: customThemeText(
                          "Madhapur, Hyderabad, Telangana - 560034.",
                          13,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  // Property name
                  Row(
                    children: [
                      Icon(Icons.home, size: 16, color: AppColors.black1),
                      SizedBox(width: 6),
                      Expanded(
                        child: customThemeText(
                          "3 BHK Flat in Madhapur",
                          13,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  // Contact
                  Row(
                    children: [
                      Icon(Icons.person, size: 16, color: AppColors.black1),
                      SizedBox(width: 6),
                      Expanded(
                        child: customThemeText(
                          "Mr. Santhosh Kumar, Ph.No: +91 1223456789",
                          13,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  // Buttons
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding:
                          EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.green1,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          alignment: Alignment.center,
                          child: customThemeText("Changed Slot", 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.vendorPrimary),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          padding:
                          EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.red2,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          alignment: Alignment.center,
                          child: customThemeText("Cancel", 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.red3),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
          ],
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

