
import 'package:eimi_buy_or_sell_app/utils/app_colors.dart';
import 'package:eimi_buy_or_sell_app/utils/base_bloc/base_state.dart';
import 'package:eimi_buy_or_sell_app/utils/core/core.dart';
import 'package:eimi_buy_or_sell_app/vendor/product_upload_screen.dart';
import 'package:eimi_buy_or_sell_app/vendor/vendor_home/vendor_home_bloc/vendor_home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';





class SubCategorySelectionScreen extends StatefulWidget {
  const SubCategorySelectionScreen({super.key});

  @override
  State<SubCategorySelectionScreen> createState() => _SubCategorySelectionScreenState();
}

class _SubCategorySelectionScreenState extends State<SubCategorySelectionScreen> {
  final VendorHomeBloc _bloc = VendorHomeBloc();
  final ScrollController _scrollController = ScrollController();
  _SubCategorySelectionScreenState();

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
                                children:  [
                                  //BODY WIDGETS
                                  InkWell(
                                    onTap: (){
                                      Navigator.pop(context);
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.arrow_back),
                                        HorizontalSpace(),
                                        customThemeText(
                                            'Real Estate & Properties',
                                            18,fontWeight: FontWeight.w700,color: AppColors.black
                                        ),

                                      ],
                                    ),
                                  ),

                                  subCategoriesListWidget(),

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
  Widget subCategoriesListWidget() {
    return Container(
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 0.8,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProductUploadScreen()),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                  decoration: BoxDecoration(
                      color: AppColors.grey10,
                      borderRadius: BorderRadius.circular(16)

                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.asset("assets/images/home_image.png",height: deviceHeight(context) * 0.12,width: deviceWidth(context)* 0.3,),
                      VerticalSpace(),
                      customThemeText(
                          'Real Estate & Properties',
                          16,fontWeight: FontWeight.w600,color: AppColors.black
                      ),
                    ],
                  ),
                ),

              ],
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

