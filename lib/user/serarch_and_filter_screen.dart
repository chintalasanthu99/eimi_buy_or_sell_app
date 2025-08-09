
import 'dart:convert';

import 'package:eimi_buy_or_sell_app/user/product_card.dart';
import 'package:eimi_buy_or_sell_app/utils/app_colors.dart';
import 'package:eimi_buy_or_sell_app/utils/base_bloc/base_bloc.dart';
import 'package:eimi_buy_or_sell_app/utils/base_bloc/base_state.dart';
import 'package:eimi_buy_or_sell_app/utils/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';


class SearchAndFilterScreen extends StatefulWidget {
  final String? isFrom;
  const SearchAndFilterScreen({super.key,this.isFrom});

  @override
  State<SearchAndFilterScreen> createState() => _SearchAndFilterScreenState();
}

class _SearchAndFilterScreenState extends State<SearchAndFilterScreen> {
  final BaseBloc _bloc = BaseBloc();
  final ScrollController _scrollController = ScrollController();
  final List<String> suggestions = [
    "Coworking",
    "Property",
    "iPhone",
    "Resorts",
    "Commercial Property",
    "Luxury Villas",
    "Studio Apartments",
    "Farm Houses",
  ];
  final List<Map<String, dynamic>> allProducts = [];

  _SearchAndFilterScreenState();

  @override
  void initState() {
    initPlatformState();
    callProductsApi();
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
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back),
                          HorizontalSpace(),
                          Expanded(
                              child: _buildSearchBar()),

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

                              _buildSearchSuggestions(),
                              VerticalSpace(height: 10,),
                              _buildProductsWidget(),

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
          hintText: "Search for Products",
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

  Widget _buildSearchSuggestions() {
    return Visibility(
      visible: widget.isFrom!=null && widget.isFrom=="search",
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: suggestions.map((text) {
          return Chip(
            avatar: Image.asset(
              "assets/images/arrow_up_right.png",
              width: 16, height: 16,
            ),
            label: customThemeText(
              text,
                14,color: AppColors.black
            ),
            backgroundColor: AppColors.grey10,
            labelPadding: const EdgeInsets.symmetric(horizontal: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Colors.transparent, width: 0),
            ),

            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildProductsWidget(){
    return Container(
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
          childAspectRatio: 0.94,
        ),
        itemCount: 5,
        itemBuilder: (context, index) {
          return ProductCard(
            item: allProducts[index],
            layout: "list",
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
  Future<void> callProductsApi() async {
    final String response = await rootBundle.loadString('assets/jsons/products.json');
    final List<dynamic> data = jsonDecode(response);

    setState(() {
      allProducts.clear();
      allProducts.addAll(data.cast<Map<String, dynamic>>());
      print(allProducts.length);
    });
  }


}
