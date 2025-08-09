import 'package:eimi_buy_or_sell_app/utils/app_colors.dart';
import 'package:eimi_buy_or_sell_app/utils/base_bloc/base_state.dart';
import 'package:eimi_buy_or_sell_app/utils/core/core.dart';
import 'package:eimi_buy_or_sell_app/vendor/vendor_home/vendor_home_bloc/vendor_home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';




class UserWishlistScreen extends StatefulWidget {
  const UserWishlistScreen({super.key});

  @override
  State<UserWishlistScreen> createState() => _UserWishlistScreenState();
}

class _UserWishlistScreenState extends State<UserWishlistScreen> {
  final VendorHomeBloc _bloc = VendorHomeBloc();
  final ScrollController _scrollController = ScrollController();
  _UserWishlistScreenState();

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
                  Container(
                    padding: EdgeInsets.only(left: 16, top: 10),
                    child: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back),
                          HorizontalSpace(),
                          customThemeText("Wishlist", 18,fontWeight: FontWeight.w700,color: AppColors.black),

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
                              VerticalSpace(height: 0,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:  [
                                  //BODY WIDGETS
                                  _buildSearchBar(),
                                  VerticalSpace(),
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
                Card(

                  color: AppColors.white,
                  child: Row(
                    children: [
                      Container(
                        height: deviceHeight(context)*0.14,
                        width: deviceWidth(context)/3,
                        decoration: BoxDecoration(

                            image: DecorationImage(
                              fit: BoxFit.fill,
                                image: AssetImage("assets/images/product_image.png"))
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 10,bottom: 10),
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(child: customThemeText("2 BHK Apartment In Madhapur", 16,fontWeight: FontWeight.w700,color: AppColors.black10)),
                                  Container(
                                    padding: EdgeInsets.only(right: 6,top: 0),
                                    child: Image.asset("assets/images/heart_fill.png",height: 24,width: 24,color: Colors.pinkAccent,),
                                  )
                                ],
                              ),
                              customThemeText("Real Estate/Lease", 14,fontWeight: FontWeight.w600,color: AppColors.black1),
                              customThemeText("View Details", 14,fontWeight: FontWeight.w500,color: AppColors.primary),
                            ],
                          ),
                        ),
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

