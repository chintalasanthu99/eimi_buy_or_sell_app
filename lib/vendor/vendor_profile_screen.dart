import 'package:eimi_buy_or_sell_app/utils/app_colors.dart';
import 'package:eimi_buy_or_sell_app/utils/base_bloc/base_state.dart';
import 'package:eimi_buy_or_sell_app/utils/core/core.dart';
import 'package:eimi_buy_or_sell_app/vendor/edit_vendor_profile_screen.dart';
import 'package:eimi_buy_or_sell_app/vendor/vendor_booking.dart';
import 'package:eimi_buy_or_sell_app/vendor/vendor_home/vendor_home_bloc/vendor_home_bloc.dart';
import 'package:eimi_buy_or_sell_app/vendor/vendor_notificatons_screen.dart';
import 'package:eimi_buy_or_sell_app/vendor/vendor_review_screen.dart';
import 'package:eimi_buy_or_sell_app/vendor/vendor_settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';


class VendorProfileDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> vendorProfile;

  const VendorProfileDetailsScreen({super.key, required this.vendorProfile});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                          vendorProfile["avatar"] ??
                              'https://i.pravatar.cc/150?img=10',
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        vendorProfile["name"] ?? "Vendor Name",
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onBackground,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        vendorProfile["shop"] ?? "Shop Name",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onBackground.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.location_on, size: 16, color: colorScheme.onBackground.withOpacity(0.6)),
                          const SizedBox(width: 4),
                          Text(
                            vendorProfile["location"] ?? "Location",
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onBackground.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Positioned(
                  top: 12,
                  right: 12,
                  child: Material(
                    color: colorScheme.surface,
                    shape: const CircleBorder(),
                    elevation: 2,
                    child: IconButton(
                      icon: Icon(Icons.edit, size: 20, color: colorScheme.primary),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditVendorProfileScreen(vendorProfile: vendorProfile),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              color: colorScheme.surface,
              child: ListTile(
                leading: Icon(Icons.phone, color: colorScheme.primary),
                title: Text("Contact", style: TextStyle(color: colorScheme.onSurface)),
                subtitle: Text(
                  vendorProfile["contact"] ?? "N/A",
                  style: TextStyle(color: colorScheme.onSurface.withOpacity(0.8)),
                ),
              ),
            ),

            const SizedBox(height: 20),


            Column(
              children: [
                _buildSectionTile(context, Icons.calendar_today, "Bookings", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => VendorBookingsScreen()),
                  );
                }),
                _buildSectionTile(context, Icons.rate_review, "Reviews", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => VendorReviewsScreen()),
                  );
                }),
                _buildSectionTile(context, Icons.settings, "Settings", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => VendorSettingsScreen()),
                  );
                }),
              ],
            ),

            const SizedBox(height: 30),

            TextButton.icon(
              icon: Icon(Icons.logout, color: colorScheme.error),
              label: Text("Logout", style: TextStyle(color: colorScheme.error)),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Confirm Logout"),
                    content: const Text("Are you sure you want to logout?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          // Add logout functionality here
                        },
                        child: Text("Logout", style: TextStyle(color: colorScheme.error)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTile(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 0.8,
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        leading: Icon(icon, color: colorScheme.primary),
        title: Text(title, style: TextStyle(color: colorScheme.onSurface)),
        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: colorScheme.onSurface.withOpacity(0.6)),
        onTap: onTap,
      ),
    );
  }
}




class VendorProfileScreen extends StatefulWidget {
  const VendorProfileScreen({super.key});

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
                                  Container(
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 40,
                                          backgroundImage: AssetImage("assets/images/profile_defalut.jpg"),
                                        ),
                                        Column(
                                          children: [
                                            customThemeText("Santhosh", 18,fontWeight: FontWeight.w700,color: AppColors.black),
                                            customThemeText("Electronics", 16,fontWeight: FontWeight.w600,color: AppColors.black3),
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
        if(title=="Appointments"){
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
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Image.asset(image,color: AppColors.black,height: 20,width: 20,),
            HorizontalSpace(),
            customThemeText(title, 16,fontWeight: FontWeight.w500,color: AppColors.black),
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
