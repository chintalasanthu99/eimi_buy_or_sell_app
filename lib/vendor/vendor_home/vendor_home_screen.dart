import 'package:Eimi/user/location_drop_down.dart';
import 'package:Eimi/utils/AppDataHelper.dart';
import 'package:Eimi/utils/app_colors.dart';
import 'package:Eimi/utils/base_bloc/base_state.dart';
import 'package:Eimi/utils/core/core.dart';
import 'package:Eimi/vendor/category_selection_screen.dart';
import 'package:Eimi/vendor/vendor_home/vendor_home_bloc/vendor_home_bloc.dart';
import 'package:Eimi/vendor/vendor_notificatons_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';


class VendorHomePage extends StatefulWidget {
  Function(int)? onBackClick;
  VendorHomePage({super.key,this.onBackClick});

  @override
  State<VendorHomePage> createState() => _VendorHomePageState();
}

class _VendorHomePageState extends State<VendorHomePage> {
  final VendorHomeBloc _bloc = VendorHomeBloc();
  final ScrollController _scrollController = ScrollController();
  String selectedLocation = 'Hyderabad';

  _VendorHomePageState();

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


                  //BODY
                  Expanded(
                    child: Container(
                      color: AppColors.white,
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Container(
                          margin:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              appBarWidget(),
                              VerticalSpace(height: 16),
                              productBannerWidget(),
                              VerticalSpace(height: 16,),
                              statsWidget(),


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
  void _showLocationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: LocationDropdown(
            selected: selectedLocation,
            onChanged: (val) {
              Navigator.pop(context);
              setState(() => selectedLocation = val);
            },
          ),
        );
      },
    );
  }

  Widget appBarWidget(){
    return Container(
      color: AppColors.transparent,

      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VerticalSpace(height: 20,),
          customThemeText("Hi Santhosh", 16,fontWeight: FontWeight.w700),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: (){
                  _showLocationBottomSheet(context);
                },
                child: Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: AppColors.black),
                    const SizedBox(width: 4),
                    customThemeText(selectedLocation, 14,fontWeight: FontWeight.w500,color: AppColors.black),
                    const Icon(Icons.arrow_forward_ios_rounded, size: 10),
                  ],
                ),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const VendorNotificationScreen()),
                      );
                    },
                      child: Icon(Icons.notification_important_rounded, size: 24, color: AppColors.black)),
                ],
              ),
            ],
          ),
        ],
      ),

    );
  }

  Widget productBannerWidget(){
    return  InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CategorySelectionScreen()),
        );
      },
      child: Container(
        height: deviceHeight(context)/7,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/bg_listing_home.png"),
                fit: BoxFit.fill
            )
        ),
        child: Row(
          children: [
            Flexible(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 10,bottom: 10),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VerticalSpace(height: deviceHeight(context)/24,),
                    Row(
                      children: [
                        customThemeText("Post New Listing", 18,fontWeight: FontWeight.w600,color: AppColors.black10),
                        Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.black),
                      ],
                    ),
                    customThemeText("List your offer and reach the right people.", 14,fontWeight: FontWeight.w400,color: AppColors.black),
                  ],
                ),
              ),

            ),
            Flexible(
              flex: 1,
              child: Container(

              ),
            )
          ],
        ),
      ),
    );
  }

  Widget statsWidget() {
    return Container(
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 1.1,
        ),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            // elevation: 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.green10,

            ),
            // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.only(left: 10,bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customThemeText(
                    '100',
                      40,fontWeight: FontWeight.w700,color: AppColors.black10
                  ),
                  customThemeText(
                    'Total Products Listed',
                    16,fontWeight: FontWeight.w700,color: AppColors.black
                  ),
                ],
              ),
            ),
          );
        },
      ),
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


