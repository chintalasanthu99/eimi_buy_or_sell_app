import 'package:Eimi/user/user_bookings_screen.dart';
import 'package:Eimi/user/home/user_home_screen.dart';
import 'package:Eimi/user/user_profile_screen.dart';
import 'package:Eimi/utils/app_colors.dart';
import 'package:flutter/material.dart';


class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _currentIndex = 0;
  late List<Widget> _children;
  @override
  void initState() {

    _children = [
      UserHomeScreen(onBackClick:onTabTapped),
      UserBookingsScreen(onBackClick:onTabTapped),
      UserProfileScreen(onBackClick:onTabTapped),
    ];
    super.initState();
  }


  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: AppColors.white,
        selectedItemColor:  AppColors.primary,
        unselectedItemColor:  AppColors.grey3,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Bookings"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
