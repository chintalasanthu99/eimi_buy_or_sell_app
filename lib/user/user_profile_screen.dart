import 'package:Eimi/auth/on_boarding_screeen.dart';
import 'package:Eimi/user/review_screen.dart';
import 'package:Eimi/user/user_bookings_screen.dart';
import 'package:Eimi/user/user_edit_profile_screen.dart';
import 'package:Eimi/user/user_notifications_screen.dart';
import 'package:Eimi/user/user_settings_screen.dart';
import 'package:Eimi/user/user_wish_list_screen.dart';
import 'package:Eimi/utils/AppDataHelper.dart';
import 'package:Eimi/utils/app_colors.dart';
import 'package:Eimi/utils/base_bloc/base_bloc.dart';
import 'package:Eimi/utils/base_bloc/base_state.dart';
import 'package:Eimi/utils/core/core.dart';
import 'package:Eimi/utils/network/DataModule.dart';
import 'package:Eimi/utils/size_utils.dart';
import 'package:Eimi/utils/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../auth/login_screen.dart';





class UserProfileScreen extends StatefulWidget {
  final Function(int)? onBackClick;
  const UserProfileScreen({super.key,this.onBackClick});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final BaseBloc _bloc = BaseBloc();
  final ScrollController _scrollController = ScrollController();
  _UserProfileScreenState();

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
                              VerticalSpace(height: 10,),
                              Column(
                                children:  [
                                  //BODY WIDGETS
                                  // Profile Header
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (_) => const UserEditProfileScreen()),
                                      );
                                    },
                                    child: Container(
                                      width: deviceWidth(context),
                                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                                      margin: const EdgeInsets.only(bottom: 20),
                                      decoration: BoxDecoration(
                                        color: AppColors.grey10,
                                        borderRadius: BorderRadius.circular(16),
                                        // boxShadow: [
                                        //   BoxShadow(
                                        //     color: AppColors.black10,
                                        //     blurRadius: 8,
                                        //     offset: const Offset(0, 4),
                                        //   ),
                                        // ],
                                      ),
                                      child: Column(
                                        children: [
                                          const CircleAvatar(
                                            radius: 50,
                                            backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=5"),
                                          ),
                                          SizeUtils.height10,
                                          customThemeText("John Doe",16 ,fontWeight: FontWeight.w700),
                                          SizeUtils.height6,
                                          customThemeText(
                                            "johndoe@example.com",14,fontWeight: FontWeight.w500, color: AppColors.black
                                          ),
                                          SizeUtils.height6,
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                            decoration: BoxDecoration(
                                              color: AppColors.green10,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              "Tap to edit",
                                              style: TextUtils.smallTextStyle(context).copyWith(
                                                color: AppColors.primary,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  // Options List
                                  _buildCard(context, children: [
                                    _buildOption(
                                      context,
                                      icon: Icons.favorite_border,
                                      label: "My Wishlist",
                                      destination: const UserWishlistScreen(),
                                    ),
                                    _buildOption(
                                      context,
                                      icon: Icons.book_online_outlined,
                                      label: "My Bookings"
                                    ),
                                    _buildOption(
                                      context,
                                      icon: Icons.rate_review_outlined,
                                      label: "My Reviews",
                                      destination: const ReviewScreen(),
                                    ),
                                    _buildOption(
                                      context,
                                      icon: Icons.notifications_outlined,
                                      label: "Notifications",
                                      destination:  UserNotificationScreen(),
                                    ),
                                    _buildOption(
                                      context,
                                      icon: Icons.settings,
                                      label: "Settings",
                                      destination: const UserSettingsScreen(),
                                    ),
                                  ]),

                                  SizeUtils.height20,

                                  // Logout Button
                                  _buildCard(
                                    context,
                                    children: [
                                      ListTile(
                                        leading: Icon(Icons.logout, color: AppColors.primary),
                                        title: customThemeText(
                                          "Logout",
                                          14,color: AppColors.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        onTap: () => _showLogoutDialog(context),
                                      ),
                                    ],
                                  )
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

  Widget _buildCard(BuildContext context, {required List<Widget> children}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        // color: AppColors.grey6,
        borderRadius: BorderRadius.circular(12),
        // boxShadow: [
        //   BoxShadow(
        //     color: AppColors.black2,
        //     blurRadius: 6,
        //     offset: const Offset(0, 3),
        //   ),
        // ],
      ),
      child: Column(children: children),
    );
  }

  // ListTile builder
  Widget _buildOption(
      BuildContext context, {
        required IconData icon,
        required String label,
         Widget? destination
      }) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).iconTheme.color),
      title: customThemeText(label, 14,fontWeight: FontWeight.w400),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        if(label=="My Bookings"){
          widget.onBackClick!(1);
        }else{
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => destination!),
          );
        }

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

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title:  customThemeText("Confirm Logout",14),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            child:  customThemeText("Cancel",14),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            child: const Text("Logout"),
            onPressed: () {
              DataModule().clearData();
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const OnBoardingScreen()),
                    (route) => false,
              );
            },
          ),
        ],
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

