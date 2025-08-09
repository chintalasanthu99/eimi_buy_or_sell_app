import 'dart:convert';
import 'package:eimi_buy_or_sell_app/user/category_card_widget.dart';
import 'package:eimi_buy_or_sell_app/user/home/home_bloc/home_bloc.dart';
import 'package:eimi_buy_or_sell_app/user/home/home_bloc/home_event.dart';
import 'package:eimi_buy_or_sell_app/user/home/models/category_filter_request.dart';
import 'package:eimi_buy_or_sell_app/user/location_drop_down.dart';
import 'package:eimi_buy_or_sell_app/user/serarch_and_filter_screen.dart';
import 'package:eimi_buy_or_sell_app/user/sub_category_screen.dart';
import 'package:eimi_buy_or_sell_app/user/user_notifications_screen.dart';
import 'package:eimi_buy_or_sell_app/user/user_wish_list_screen.dart';
import 'package:eimi_buy_or_sell_app/utils/app_colors.dart';
import 'package:eimi_buy_or_sell_app/utils/base_bloc/base_state.dart';
import 'package:eimi_buy_or_sell_app/utils/core/core.dart';
import 'package:eimi_buy_or_sell_app/vendor/models/Category.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../product_card.dart';


class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  final UserHomeBloc _bloc = UserHomeBloc();
  final ScrollController _scrollController = ScrollController();
  String selectedLocation = 'Hyderabad';
  String selectedCategory = 'All';

  TextEditingController searchController = TextEditingController();
  String searchQuery = '';



  final List<Map<String, dynamic>> allProducts = [];
  final List<Category> categories = [];
  _UserHomeScreenState();

  @override
  void initState() {
    initPlatformState();
    callCategoriesApi();
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
    return BlocListener<UserHomeBloc, BaseState>(listener: (context, state) async {
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
    }, child: BlocBuilder<UserHomeBloc, BaseState>(
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
                                  _buildAppBar(),
                                   VerticalSpace(height: 20,),
                                  _buildSearchBar(),
                                   VerticalSpace(height: 20),
                                  _buildCategorySection(),
                                   VerticalSpace(height: 16),
                                  _buildSection("Today’s Picks", _getNewArrivals()),
                                  _buildSection("Recommended ", _getTopFavorites()),
                                  _buildSection("All Products", allProducts, isGrid: true),
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
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SearchAndFilterScreen(isFrom: "search",)),
        );
      },
      child: Container(
        padding: EdgeInsets.only(left: 10,right: 10),
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.grey10,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.search_outlined,color:AppColors.grey1 ,),
            customThemeText("Search for products or  categories...", 14),
            Icon(Icons.mic_none_outlined,color:AppColors.grey1 ,),

            // TextField(
            //   readOnly: true,
            //   onSubmitted: (value) {},
            //   textInputAction: TextInputAction.done,
            //   keyboardType: TextInputType.text,
            //   // controller: searchController,
            //   // onChanged: onSearchChanged,
            //   style: const TextStyle(
            //     color: Colors.black,
            //     fontSize: 14,
            //   ),
            //   inputFormatters: [
            //     FilteringTextInputFormatter.allow(RegExp('[A-Z]')),
            //     // Allow only capital letters
            //   ],
            //   textCapitalization: TextCapitalization.characters,
            //   decoration: InputDecoration(
            //     fillColor: AppColors.grey10,
            //     filled: true,
            //     prefixIcon: Icon(Icons.search_outlined,color:AppColors.grey1 ,),
            //     suffixIcon: Icon(Icons.mic_none_outlined,color:AppColors.grey1 ,),
            //     contentPadding: const EdgeInsets.only(left: 10),
            //     hintText: "Search for products or  categories...",
            //     hintStyle: const TextStyle(
            //         color: Colors.grey, fontWeight: FontWeight.w400,fontSize: 14,fontFamily: "Manrope"),
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(8),
            //       borderSide: BorderSide(
            //           width: 0.0, color: AppColors.grey10),
            //     ),
            //     focusedBorder: OutlineInputBorder(
            //         borderRadius:
            //         const BorderRadius.all(Radius.circular(8.0)),
            //         borderSide: BorderSide(
            //             color: AppColors.primary, width: 0.0)),
            //     enabledBorder: OutlineInputBorder(
            //       borderRadius:
            //       const BorderRadius.all(Radius.circular(8.0)),
            //       borderSide: BorderSide(
            //           color: AppColors.grey10, width: 0.0),
            //     ),
            //   ),
            // ),

          ],
        ),
      ),
    );
  }


  Widget _buildAppBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        customThemeText( "Hello, User 👋", 16,fontWeight: FontWeight.w700,color: AppColors.black),
        Container(
          child: MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: InkWell(
              onTap: () => _showLocationBottomSheet(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: AppColors.primary),
                      HorizontalSpace(width: 4),
                      customThemeText(selectedLocation, 14,fontWeight: FontWeight.w500,color: AppColors.black),
                      const Icon(Icons.arrow_forward_ios_rounded, size: 10),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.favorite_border),
                        tooltip: "Wishlist",
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const UserWishlistScreen()));
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.notifications_none),
                        tooltip: "Notifications",
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const UserNotificationScreen()));
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategorySection() {
    return Container(
      height: deviceHeight(context) * 0.133,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3 + 1, // extra slot for "View All"
        itemBuilder: (context, index) {
          if (index < 3) {
            // Normal category card
            final cat = categories!=null && categories.isNotEmpty?categories[index]:Category();
            return CategoryCard(
              category: cat,
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SearchAndFilterScreen(),
                  ),
                );
              },
            );
          } else {
            // "View All" card
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SubCategoryScreen(),
                  ),
                );
              },
              child: Column(
                children: [
                  Container(
                    width: deviceWidth(context) *0.24,
                    height: deviceHeight(context)*0.1,
                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      color: AppColors.grey10,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: Image.asset("assets/images/arrow_circle_right.png",height: deviceHeight(context)*0.04,),
                  ),
                  VerticalSpace()
                ],
              ),
            );
          }
        },
      ),
    );
  }


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

  List<Map<String, dynamic>> _getNewArrivals() {
    final now = DateTime.now();
    return allProducts.where((item) {
      final postedDate = DateTime.tryParse(item['postedAt'] ?? '') ?? DateTime(2000);
      final isRecent = now.difference(postedDate).inDays <= 7;
      return item['status'] == 'active' && isRecent;
    }).toList()
      ..sort((a, b) => DateTime.parse(b['postedAt']).compareTo(DateTime.parse(a['postedAt'])))
      ..take(6);
  }


  List<Map<String, dynamic>> _getTopFavorites() {
    return allProducts.where((e) => (e["likes"] ?? 0) > 0).take(6).toList();
  }

  Widget _buildSection(String title, List<Map<String, dynamic>> products, {bool isGrid = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: customThemeText(
            title,
            18,
            fontWeight: FontWeight.w700,
            color: AppColors.black
          ),
        ),
        Container(
          height: deviceHeight(context)*0.22,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: allProducts.length,
            separatorBuilder: (_, __) =>  HorizontalSpace(width: 4,),
            itemBuilder: (_, index) => Container(
              width: deviceWidth(context)*0.54,
              child: ProductCard(

                item: allProducts[index],
                layout: "list",
              ),
            ),
          ),
        ),
      ],
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
  Future<void> callCategoriesApi() async {
    final jsonStr =
    await DefaultAssetBundle.of(context).loadString("assets/jsons/categories.json");
    final List<dynamic> jsonList = json.decode(jsonStr);
    setState(() {
      categories.addAll(jsonList.map((v) => Category.fromJson(v)));
    });
    CategoryFilterRequest request = CategoryFilterRequest();
    request.page=0;
    request.size=10;
    _bloc.add(CategoryFilterEvent(request));
  }


}

