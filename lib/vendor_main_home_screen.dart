import 'package:eimi_buy_or_sell_app/utils/app_colors.dart';
import 'package:eimi_buy_or_sell_app/vendor/product_listing_screen.dart';
import 'package:eimi_buy_or_sell_app/vendor/vendor_home/vendor_home_screen.dart';
import 'package:eimi_buy_or_sell_app/vendor/vendor_profile_screen.dart';
import 'package:flutter/material.dart';

class VendorMainHomeScreen extends StatefulWidget {
  const VendorMainHomeScreen({super.key});

  @override
  State<VendorMainHomeScreen> createState() => _VendorMainHomeScreenState();
}

class _VendorMainHomeScreenState extends State<VendorMainHomeScreen> {
  int _currentIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      VendorHomePage(onBackClick: changeTab,),
      VendorProductListScreen(onBackClick: changeTab,),
      VendorProfileScreen(onBackClick: changeTab,),
    ];
  }

  void changeTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: IndexedStack(
            index: _currentIndex,
            children: _screens,
          )),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.transparent, // optional: disables the tab highlight background
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return TextStyle(color: AppColors.vendorPrimary,fontWeight: FontWeight.w700,fontFamily: "Manrope",fontSize: 12);
            }
            return const TextStyle(color: Colors.grey);
          }),
          iconTheme: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return IconThemeData(color: AppColors.vendorPrimary);
            }
            return IconThemeData(color: AppColors.grey3);
          }),
        ),
        child: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: changeTab,
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_filled,size: 36,), label: 'Home',),
            NavigationDestination(icon: Icon(Icons.list_alt_outlined), label: 'Products'),
            NavigationDestination(icon: Icon(Icons.person_outline_outlined), label: 'Profile'),
          ],
        ),
      )
      ,
    );
  }
}


