import 'package:Eimi/utils/app_colors.dart';
import 'package:Eimi/utils/base_bloc/base_state.dart';
import 'package:Eimi/utils/core/core.dart';
import 'package:Eimi/vendor/vendor_home/vendor_home_bloc/vendor_home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';


class VendorBookingsScreen extends StatefulWidget {
  const VendorBookingsScreen({super.key});

  @override
  State<VendorBookingsScreen> createState() => _VendorBookingsScreenState();
}

class _VendorBookingsScreenState extends State<VendorBookingsScreen> {
  final VendorHomeBloc _bloc = VendorHomeBloc();
  final ScrollController _scrollController = ScrollController();
  DateTime currentMonth = DateTime.now();
  int selectedIndex = 0;
  late int selectedDay;
  late List<DateTime> daysInMonth;


  void _updateDaysInMonth() {
    final firstDay = DateTime(currentMonth.year, currentMonth.month, 1);
    final daysCount = DateTime(currentMonth.year, currentMonth.month + 1, 0).day;
    daysInMonth = List.generate(daysCount, (i) => firstDay.add(Duration(days: i)));
  }

  void goToPrevMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month - 1, 1);
      selectedDay = 1;
      _updateDaysInMonth();
    });
  }

  void goToNextMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month + 1, 1);
      selectedDay = 1;
      _updateDaysInMonth();
    });
  }
  _VendorBookingsScreenState();

  @override
  void initState() {
    initPlatformState();
    selectedDay = DateTime.now().day;
    _updateDaysInMonth();
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
              backgroundColor: AppColors.vendorPrimary),
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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back),
                          HorizontalSpace(),
                          customThemeText("Appointments", 18,fontWeight: FontWeight.w700,color: AppColors.black),

                        ],
                      ),
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
                                  VerticalSpace(height: 16,),
                                  _calenderWidget(),
                                  VerticalSpace(height: 16,),
                                  _buildBookingListWidget(),

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

  Widget _calenderWidget(){
    return // Month and Arrows
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: goToPrevMonth,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: AppColors.grey7.withValues(alpha: 0.80),
                      child: Icon(Icons.arrow_back_ios_new_rounded,color: AppColors.black4,size: 16,))),
              customThemeText(DateFormat('MMMM').format(currentMonth), 18,fontWeight: FontWeight.w700,color: AppColors.black),

              InkWell(
                  onTap: goToNextMonth,
                  child: CircleAvatar(
                      radius: 16,
                      backgroundColor: AppColors.grey7.withValues(alpha: 0.80),
                      child: Icon(Icons.arrow_forward_ios_rounded,color: AppColors.black4,size: 16,))),
            ],
          ),
          VerticalSpace(height: 12,),
          Container(
            height: deviceHeight(context)/8,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 0),
              itemCount: daysInMonth.length,
              separatorBuilder: (_, __) => SizedBox(width: 8),
              itemBuilder: (context, index) {
                final day = daysInMonth[index];
                final isSelected = day.day == selectedDay;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDay = day.day;
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 180),
                    width: 62,
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.green1
                          : AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? AppColors.vendorPrimary : AppColors.black2,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customThemeText(  DateFormat('E').format(day), 14,fontWeight: FontWeight.w600,color: isSelected ?AppColors.vendorPrimary:AppColors.grey8),
                        VerticalSpace(height: 4),
                        customThemeText(DateFormat('d').format(day), 14,fontWeight: FontWeight.w600,color: isSelected ?AppColors.vendorPrimary:AppColors.grey8),
                        VerticalSpace(height: 2),
                        customThemeText( DateFormat('MMM').format(day), 14,fontWeight: FontWeight.w600,color: isSelected ?AppColors.vendorPrimary:AppColors.grey8),

                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
  }

  Widget _buildBookingListWidget(){
    return Container(
      height: deviceHeight(context),
      child: ListView.builder(
          itemCount: 4,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context,int i){
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10,bottom: 10,right: 10,top: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(width: 1,color: AppColors.black2)
                  ),
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Image.asset("assets/images/list_icon.png",height: 24,width: 24,color: AppColors.black,),
                            customThemeText("9:30 AM to 10:00 AM", 16,fontWeight: FontWeight.w700,color: AppColors.black10)
                          ],
                        ),
                      ),
                      VerticalSpace(height: 10,),
                      Container(
                        child: Row(
                          children: [
                            Image.asset("assets/images/list_icon.png",height: 16,width: 16,color: AppColors.black1,),
                            HorizontalSpace(),
                            Expanded(child: customThemeText("Madhapur, Hyderabad, Telangana - 560034.", 13,fontWeight: FontWeight.w500,color: AppColors.black1))
                          ],
                        ), 
                      ),
                      VerticalSpace(height: 10,),
                      Container(
                        child: Row(
                          children: [
                            Image.asset("assets/images/list_icon.png",height: 16,width: 16,color: AppColors.black1,),
                            HorizontalSpace(),
                            Expanded(child: customThemeText("3 BHK Flat in Madhapur", 13,fontWeight: FontWeight.w500,color: AppColors.black1))
                          ],
                        ),
                      ),
                      VerticalSpace(height: 10,),
                      Container(
                        child: Row(
                          children: [
                            Image.asset("assets/images/list_icon.png",height: 16,width: 16,color: AppColors.black1,),
                            HorizontalSpace(),
                            Expanded(child: customThemeText("Mr. Santhosh Kumar, Ph.No: +91 1223456789", 13,fontWeight: FontWeight.w500,color: AppColors.black1))
                          ],
                        ),
                      ),
                      VerticalSpace(),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 6,vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.green1,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(width: 1,color: AppColors.green1)
                              ),
                              child: customThemeText("Reschedule", 16,fontWeight: FontWeight.w700,color: AppColors.vendorPrimary,textAlign: TextAlign.center),

                            ),
                          ),
                          HorizontalSpace(),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 6,vertical: 4),
                              decoration: BoxDecoration(
                                  color: AppColors.red2,
                                  borderRadius: BorderRadius.circular(6)
                              ),
                              child: customThemeText("Cancel", 16,fontWeight: FontWeight.w700,color: AppColors.red3,textAlign: TextAlign.center),

                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                VerticalSpace()
              ],
            );
          }),
    );
  }



  //FUNCTIONALITY
  void _showToastBar(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 6,
        backgroundColor : AppColors.vendorPrimary,
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
        backgroundColor: AppColors.vendorPrimary,
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

class CalendarDay {
  final DateTime date;
  final bool isSelected;
  final bool isDisabled;

  CalendarDay({
    required this.date,
    this.isSelected = false,
    this.isDisabled = false,
  });
}

