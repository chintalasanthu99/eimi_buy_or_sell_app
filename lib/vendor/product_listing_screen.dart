import 'package:Eimi/utils/app_colors.dart';
import 'package:Eimi/utils/base_bloc/base_state.dart';
import 'package:Eimi/utils/core/core.dart';
import 'package:Eimi/vendor/vendor_home/vendor_home_bloc/vendor_home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';




class VendorProductListScreen extends StatefulWidget {
  Function(int)? onBackClick;
   VendorProductListScreen({super.key,this.onBackClick});

  @override
  State<VendorProductListScreen> createState() => _VendorProductListScreenState();
}

class _VendorProductListScreenState extends State<VendorProductListScreen> {
  final VendorHomeBloc _bloc = VendorHomeBloc();
  final ScrollController _scrollController = ScrollController();
  _VendorProductListScreenState();

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
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              VerticalSpace(height: 0,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:  [
                                  //BODY WIDGETS
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      customThemeText("My Listings", 18,fontWeight: FontWeight.w700,color: AppColors.black),
                                      Row(
                                        children: [
                                          customThemeText("Sort By", 14,fontWeight: FontWeight.w600,color: AppColors.vendorPrimary),
                                          Icon(Icons.keyboard_arrow_down_rounded,color: AppColors.vendorPrimary,size: 20,)
                                        ],
                                      )
                                    ],
                                  ),
                                  VerticalSpace(height: 16,),
                                  _buildSearchBar(),
                                  VerticalSpace(height: 16,),
                                  _buildProductCard(),

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
  Widget _buildSearchBar() {
    return Container(
      height: 40,
      child: TextField(
        onSubmitted: (value) {},
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.text,
        // controller: searchController,
        // onChanged: onSearchChanged,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('[A-Z]')),
          // Allow only capital letters
        ],
        textCapitalization: TextCapitalization.characters,
        decoration: InputDecoration(
          fillColor: AppColors.grey4.withValues(alpha: 0.09),
          filled: true,
          prefixIcon: Icon(Icons.search_outlined,color:AppColors.grey2 ,),
          suffixIcon: Icon(Icons.mic_none_outlined,color:AppColors.grey2 ,),
          contentPadding: const EdgeInsets.only(left: 20),
          hintText: "Search your listings",
          hintStyle:  TextStyle(
              color: AppColors.grey5.withValues(alpha: 0.6), fontWeight: FontWeight.w400,fontSize: 14,fontFamily: "Manrope"),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
                width: 0.0, color: AppColors.grey4.withValues(alpha: 0.12)),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius:
              const BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(
                  color: AppColors.grey4.withValues(alpha: 0.12), width: 0.0)),
          enabledBorder: OutlineInputBorder(
            borderRadius:
            const BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(
                color: AppColors.grey4.withValues(alpha: 0.12), width: 0.0),
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(){
    return Container(
      child: ListView.builder(
          itemCount: 4,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context,int i){
        return Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10,bottom: 10,right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 1,color: AppColors.black2)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: deviceHeight(context)/6,
                        width: deviceWidth(context)/3,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage("assets/images/car_product2.png"))
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 10),
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customThemeText("2 BHK Apartment In Madhapur", 18,fontWeight: FontWeight.w700,color: AppColors.black10),
                              customThemeText("Real Estate/Lease", 16,fontWeight: FontWeight.w600,color: AppColors.black1),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 6,vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.red1,
                                  borderRadius: BorderRadius.circular(6)
                                ),
                                child: customThemeText("Rejected", 14,fontWeight: FontWeight.w700,color: AppColors.black10),

                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  customThemeText("Submitted On : 15 Jan 2025", 14,fontWeight: FontWeight.w500,color: AppColors.black),
                  customThemeText("Your listing was rejected due to low-quality images. Please upload clearer photos and resubmit.", 12,fontWeight: FontWeight.w500,color: AppColors.black1),
                  VerticalSpace(),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 6,vertical: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                            border: Border.all(width: 1,color: AppColors.vendorPrimary)
                          ),
                          child: customThemeText("Delete", 16,fontWeight: FontWeight.w700,color: AppColors.vendorPrimary,textAlign: TextAlign.center),
                        
                        ),
                      ),
                      HorizontalSpace(),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 6,vertical: 4),
                          decoration: BoxDecoration(
                              color: AppColors.vendorPrimary,
                              borderRadius: BorderRadius.circular(6)
                          ),
                          child: customThemeText("Re-submit", 16,fontWeight: FontWeight.w700,color: AppColors.white,textAlign: TextAlign.center),
                        
                        ),
                      )
                    ],
                  )
                ],
              ) ,
            ),
            VerticalSpace(height: 16,)
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

